import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:wonders/common_libs.dart';
import 'package:http/http.dart' as http;
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

final int minYear = wondersLogic.startYear;
final int maxYear = wondersLogic.endYear;
const int maxRequests = 32;

class ArtifactSearchHelper extends StatefulWidget {
  const ArtifactSearchHelper({Key? key}) : super(key: key);

  @override
  State<ArtifactSearchHelper> createState() => _ArtifactSearchHelperState();
}

class _ArtifactSearchHelperState extends State<ArtifactSearchHelper> {
  String selectedWonder = 'All';
  int maxIds = 1000, maxPriority = 200;

  List<WonderData> wonderQueue = [];
  WonderData? wonder;

  List<String> queryQueue = [];
  bool priority = false;

  List<int> idQueue = <int>[];
  HashSet<int> idSet = HashSet();
  HashMap<String, List<int>> errors = HashMap();
  List<_Entry> entries = <_Entry>[];

  http.Client _http = http.Client();
  int activeRequestCount = 0;
  List<String> log = [];
  Stopwatch timer = Stopwatch();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(32.0),
          child: _buildContent(context),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _http.close();
    super.dispose();
  }

  void _run() {
    // reset:
    errors.clear();
    log.clear();
    timer..reset()..start();

    if (selectedWonder == 'All') {
      wonderQueue = wondersLogic.all.toList();
    } else {
      wonderQueue = [wondersLogic.all.firstWhere((o) => o.title == selectedWonder)];
    }
    _log('Loading data for ${wonderQueue.length} wonders');
    _http = http.Client();
    _nextWonder();
  }

  void _nextWonder() {
    // reset:
    idQueue.clear();
    idSet.clear();
    entries.clear();
    activeRequestCount = 0;

    if (wonderQueue.isEmpty) {
      return _complete();
    }
    wonder = wonderQueue.removeAt(0);
    _log('\n${wonder!.title}');
    queryQueue = queries[wonder!.type]!.toList();
    _nextQuery();
  }

  Future<void> _nextQuery() async {
    if (queryQueue.isEmpty) {
      return _runIds();
    }
    String query = queryQueue.removeAt(0);
    priority = query[0] == '!';
    if (priority) query = query.substring(1);
    _log('${priority ? '*' : '-'} $query');

    Uri uri = Uri.parse(_baseQueryUri + query);
    http.Response response = await _http.get(uri);
    Map json = jsonDecode(response.body) as Map;
    List<dynamic> ids = json['objectIDs'];

    int adjustedMax = (maxIds * 1.25).round(); // add 25% to make up for errors
    int count = priority ? maxPriority : adjustedMax;
    count = min(ids.length, min(count, adjustedMax - idQueue.length));
    int foundCount = 0;

    for (int i = 0; i < ids.length && foundCount < count; i++) {
      if (idSet.add(ids[i] as int)) ++foundCount;
    }
    idQueue = idSet.toList();

    _log('    - ${ids.length} artifacts found, added $foundCount (${ids.length - foundCount} duplicates)');

    _nextQuery();
  }

  void _runIds() {
    int count = min(maxRequests, idQueue.length);
    _log('- Loading data for ${idQueue.length} artifacts');
    if (count == 0) {
      _completeIds();
      return;
    }
    while (count-- > 0) {
      _nextId();
    }
  }

  Future<void> _nextId() async {
    if (idQueue.isEmpty) return;
    activeRequestCount++;
    int id = idQueue.removeLast();
    Uri uri = Uri.parse(_baseArtifactUri + id.toString());
    String? error;
    http.Response response = await _http.get(uri);
    if (response.statusCode != 200) {
      error = 'bad status code ${response.statusCode}';
    } else {
      Map? json = jsonDecode(response.body) as Map?;
      error = _parseId(id, json);
    }
    if (error != null) {
      _logError(id, error);
    }

    _completeId();
  }

  String? _parseId(int id, Map? json) {
    if (json == null) {
      return 'could not parse json';
    } else if ((json['title'] ?? '') == '') {
      return 'missing title';
    } else if (!json.containsKey('objectBeginDate') || !json.containsKey('objectBeginDate')) {
      return 'missing years';
    }
    //} else if (!json.containsKey('isPublicDomain') || !json['isPublicDomain']) {
    //  return 'not public domain';

    int year = ((json['objectBeginDate'] as int) + (json['objectEndDate'] as int)) ~/ 2;

    if (year < minYear || year > maxYear) return 'year is out of range';

    String? imageUrlSmall = json['primaryImageSmall'];
    if (imageUrlSmall == null) return 'no small image';
    if (!imageUrlSmall.startsWith(SearchData.baseImagePath)) return 'unexpected image uri: "$imageUrlSmall"';

    imageUrlSmall = imageUrlSmall.substring(SearchData.baseImagePath.length);
    imageUrlSmall = imageUrlSmall.replaceFirst('/web-large/', '/mobile-large/');

    _Entry entry = _Entry(
      id: id,
      year: year,
      title: json['title'],
      imageUrlSmall: imageUrlSmall,
      keywords: _getKeywords(json),
    );
    entries.add(entry);
    return null;
  }

  String _getKeywords(Map json) {
    String str = '${json['objectName'] ?? ''}|${json['medium'] ?? ''}|${json['classification'] ?? ''}';
    return str.toLowerCase().replaceAll("'", "\\'").replaceAll('\r', ' ').replaceAll('\n', ' ');
  }

  void _completeId() {
    --activeRequestCount;
    if (idQueue.isNotEmpty) {
      _nextId();
    } else if (activeRequestCount == 0) {
      _completeIds();
    }
  }

  Future<void> _completeIds() async {
    _log('- Created ${entries.length} entries');
    // remove excess > maxIds?
    entries.sort((_Entry a, _Entry b) => a.year - b.year);

    // build output:
    String entryStr = '';
    for (int i = 0; i < entries.length; i++) {
      _Entry o = entries[i];
      entryStr += "  SearchData(${o.year}, ${o.id}, '${o.title}', '${o.keywords}', '${o.imageUrlSmall}'),\n";
    }

    String output = '// ${wonder!.title} (${entries.length})\nList<SearchData> _searchData = [\n$entryStr];';
    
    Directory dir = await getApplicationDocumentsDirectory();
    String type = wonder!.type.toString().split('.').last;
    String path = '${dir.path}/$type.dart';
    File file = File(path);
    await file.writeAsString(output);
    _log('- Wrote file: $type.dart');
    debugPrint(path);
    _nextWonder();
  }

  void _complete() {
    _log('\n----------\nCompleted with ${errors.length} unique errors in ${timer.elapsed.inSeconds} seconds.');
    String errorStr = '';
    errors.forEach((key, value) { errorStr += '$key (${value.length})\n'; });
    _log(errorStr);
    timer.stop();
    _http.close();
  }

  void _log(String str) {
    log.add(str);
    setState(() {});
  }

  void _logError(int id, String str) {
    if (!errors.containsKey(str)) errors[str] = [];
    errors[str]!.add(id);
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      children: [
        // input:
        SizedBox(
          width: 200,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Wonder to run:'),
            _buildWonderPicker(context),
            Gap(16),
            Text('Max items:'),
            TextFormField(
              initialValue: maxIds.toString(),
              onChanged: (s) => setState(() => maxIds = int.parse(s)),
            ),
            Gap(16),
            Text('Max priority items:'),
            TextFormField(
              initialValue: maxPriority.toString(),
              onChanged: (s) => setState(() => maxPriority = int.parse(s)),
            ),
            Gap(16),
            MaterialButton(onPressed: () => _run(), child: Text('RUN')),
          ]),
        ),
        Gap(40),

        // output:
        Expanded(
            child: ListView(
          children: log.map<Widget>((o) => Text(o)).toList(growable: false),
        )),
      ],
    );
  }

  Widget _buildWonderPicker(BuildContext context) {
    List<String> items = wondersLogic.all.map<String>((o) => o.title).toList();
    items.insert(0, 'All');

    return DropdownButton<String>(
      value: selectedWonder,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedWonder = newValue!;
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

const String _baseArtifactUri = 'https://collectionapi.metmuseum.org/public/collection/v1/objects/';

// ! as first char indicates a priority query
const String _baseQueryUri = 'https://collectionapi.metmuseum.org/public/collection/v1/search?hasImage=true&';
const Map<WonderType, List<String>> queries = {
  WonderType.chichenItza: [
    // 550 1550
    'artistOrCulture=true&q=maya', // 137
    'geoLocation=North and Central America&q=maya', // 193
  ],
  WonderType.christRedeemer: [
    // 1800 1950
    'geoLocation=Brazil&q=brazil', // 69
  ],
  WonderType.colosseum: [
    // 1 500
    '!dateBegin=1&dateEnd=500&geoLocation=Roman Empire&q=imperial rome', // 408
    'artistOrCulture=true&q=roman', // 6068
  ],
  WonderType.greatWall: [
    // -700 1650
    '!dateBegin=-700&dateEnd=1650&artistOrCulture=true&q=china', // 4540
    'geolocation=china&artistOrCulture=true&q=china', // 14181
  ],
  WonderType.machuPicchu: [
    // 1400 1600
    'geoLocation=South%20America&q=inca', // 344
  ],
  WonderType.petra: [
    // -500 500
    'artistOrCulture=true&q=nabataean', // 50
    'geoLocation=Levant&q=levant', // 346
  ],
  WonderType.pyramidsGiza: [
    // -2600 -2500
    '!dateBegin=-2650&dateEnd=-2450&geoLocation=Egypt&q=egypt', // 205
    'geoLocation=Egypt&q=egypt', // 16668
  ],
  WonderType.tajMahal: [
    // 1600 1700
    'geoLocation=India&q=mughal', // 399,
  ],
};

class _Entry {
  const _Entry({
    required this.id,
    required this.keywords,
    required this.title,
    required this.year,
    required this.imageUrlSmall,
  });

  final int id;
  final String keywords;
  final String title;
  final int year;
  final String imageUrlSmall;
}