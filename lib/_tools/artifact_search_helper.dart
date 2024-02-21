// ignore_for_file: unused_element

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';

final int minYear = wondersLogic.timelineStartYear;
final int maxYear = wondersLogic.timelineEndYear;
const int maxRequests = 32;

class ArtifactSearchHelper extends StatefulWidget {
  const ArtifactSearchHelper({super.key});

  @override
  State<ArtifactSearchHelper> createState() => _ArtifactSearchHelperState();
}

class _ArtifactSearchHelperState extends State<ArtifactSearchHelper> {
  String selectedWonder = 'All';
  int maxIds = 500, maxPriority = 200;
  bool checkImages = true;

  List<WonderData> wonderQueue = [];
  WonderData? wonder;

  List<String> queryQueue = [];
  bool priority = false;

  List<int> idQueue = <int>[];
  HashSet<int> idSet = HashSet();
  HashMap<String, List<int>> errors = HashMap();
  List<SearchData> entries = <SearchData>[];

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
    timer
      ..reset()
      ..start();

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

    int count = priority ? maxPriority : maxIds;
    count = min(ids.length, min(count, maxIds - idQueue.length));
    int foundCount = 0;

    for (int i = 0; i < ids.length && foundCount < count; i++) {
      if (idSet.add(ids[i] as int)) ++foundCount;
    }
    idQueue = idSet.toList();

    _log('    - ${ids.length} artifacts found, added $foundCount');

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
    http.Response response = await _http.get(uri);
    if (response.statusCode != 200) {
      _logError(id, 'bad status code ${response.statusCode}');
    } else {
      Map? json = jsonDecode(response.body) as Map?;
      await _parseId(id, json);
    }

    _completeId();
  }

  Future<void> _parseId(int id, Map? json) async {
    // catch all error conditions:
    if (json == null) return _logError(id, 'could not parse json');
    if ((json['title'] ?? '') == '') return _logError(id, 'missing title');
    if (!json.containsKey('objectBeginDate') || !json.containsKey('objectBeginDate')) {
      return _logError(id, 'missing years');
    }
    //if (!json.containsKey('isPublicDomain') || !json['isPublicDomain']) return _logError(id, 'not public domain')

    final int year = ((json['objectBeginDate'] as int) + (json['objectEndDate'] as int)) ~/ 2;
    if (year < minYear || year > maxYear) {
      return _logError(id, 'year is out of range');
    }

    String? imageUrlSmall = json['primaryImageSmall'];
    if (imageUrlSmall == null || imageUrlSmall.isEmpty) {
      return _logError(id, 'no small image url');
    }
    // if (!imageUrlSmall.startsWith(SearchData.baseImagePath)) {
    //   return _logError(id, 'unexpected image uri: "$imageUrlSmall"');
    // }
    // String imageUrl = imageUrlSmall.substring(SearchData.baseImagePath.length);
    // imageUrl = imageUrl.replaceFirst('/web-large/', '/mobile-large/');

    double? aspectRatio = 0;
    if (checkImages) aspectRatio = await _getAspectRatio(imageUrlSmall);
    if (aspectRatio == null) return _logError(id, 'image failed to load');

    SearchData entry = SearchData(
      year,
      id,
      _escape(json['title']),
      _getKeywords(json),
      aspectRatio,
    );

    entries.add(entry);
  }

  Future<double?> _getAspectRatio(String imagePath) async {
    Completer<double?> completer = Completer<double?>();
    NetworkImage image = NetworkImage(imagePath);
    ImageStream stream = image.resolve(ImageConfiguration());
    stream.addListener(ImageStreamListener(
      (info, _) => completer.complete(info.image.width / info.image.height),
      onError: (_, __) => completer.complete(null),
    ));
    return completer.future;
  }

  String _getKeywords(Map json) {
    String str = '${json['objectName'] ?? ''}|${json['medium'] ?? ''}|${json['classification'] ?? ''}';
    return _escape(str.toLowerCase());
  }

  String _escape(String str) => str.replaceAll("'", "\\'").replaceAll('\r', ' ').replaceAll('\n', ' ');

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

    entries.shuffle();

    // build output:
    String entryStr = '';
    for (int i = 0; i < entries.length; i++) {
      entryStr += '  ${entries[i].write()},\n';
    }

    String output = '// ${wonder!.title} (${entries.length})\nList<SearchData> _searchData = const [\n$entryStr];';

    String suggestions = _getSuggestions(entries);

    const fileNames = {
      WonderType.chichenItza: 'chichen_itza',
      WonderType.christRedeemer: 'christ_redeemer',
      WonderType.colosseum: 'colosseum',
      WonderType.greatWall: 'great_wall',
      WonderType.machuPicchu: 'machu_picchu',
      WonderType.petra: 'petra',
      WonderType.pyramidsGiza: 'pyramids_giza',
      WonderType.tajMahal: 'taj_mahal',
    };
    Directory dir = await getApplicationDocumentsDirectory();
    String name = '${fileNames[wonder!.type]}_search_data.dart';
    String path = '${dir.path}/$name';
    File file = File(path);
    await file.writeAsString('$suggestions\n\n$output');
    _log('- Wrote file: $name');
    debugPrint(path);
    _nextWonder();
  }

  void _complete() {
    _log('\n----------\nCompleted with ${errors.length} unique errors in ${timer.elapsed.inSeconds} seconds.');
    String errorStr = '';
    errors.forEach((key, value) {
      errorStr += '$key (${value.length})\n';
    });
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

  void _runSuggestions() {
    if (selectedWonder == 'All') {
      debugPrint('select a single wonder');
    } else {
      WonderData wonder = wondersLogic.all.firstWhere((o) => o.title == selectedWonder);
      debugPrint(_getSuggestions(wonder.searchData));
    }
  }

  String _getSuggestions(List<SearchData> data) {
    HashMap<String, int> counts = HashMap<String, int>();
    HashSet<String> ignore = HashSet<String>();

    // iterate through all items, and count the number of times keywords show up
    // but don't count multiple times for a single item
    for (int i = 0; i < data.length; i++) {
      ignore.clear();
      ignore.addAll([
        'and',
        'the',
        'with',
        'from',
        'for',
        'form',
        'probably',
        'back',
        'front',
        'under',
        'his',
        'one',
        'two',
        'three',
        'four',
        'part',
        'called',
        'over'
      ]);
      SearchData o = data[i];
      RegExp re = RegExp(r'\b\w{3,}\b');
      List<Match> matches = re.allMatches(o.title).toList() + re.allMatches(o.keywords).toList();
      for (int j = 0; j < matches.length; j++) {
        String match = matches[j].group(0)!.toLowerCase();
        if (ignore.contains(match)) continue;
        ignore.add(match);
        counts[match] = (counts[match] ?? 0) + 1;
      }
    }

    String str = 'List<String> _searchSuggestions = const [';

    int minCount = min(10, max(3, data.length / 60)).round();
    int suggestionCount = 0;
    counts.forEach((key, value) {
      if (value >= minCount) {
        str += "'$key', ";
        suggestionCount++;
      }
    });
    _log('- extracted $suggestionCount keyword suggestions');
    return '// Search suggestions ($suggestionCount)\n$str];';
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
            CheckboxListTile(
                title: Text('check images'), value: checkImages, onChanged: (b) => setState(() => checkImages = b!)),
            Gap(32),
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
    //'!geoLocation=Rome&q=Rome',
    //'geoLocation=Roman Empire&q=roman', // 408
    //'!q=colosseum',
    'artistOrCulture=true&q=roman', // 6068
    //'!dateBegin=-&dateEnd=500&geoLocation=Roman Empire&q=imperial rome', // 408
  ],
  WonderType.greatWall: [
    // -700 1650
    '!dateBegin=-700&dateEnd=1650&artistOrCulture=true&q=china', // 4540
    'geolocation=china&artistOrCulture=true&q=china', // 14181
  ],
  WonderType.machuPicchu: [
    // 1400 1600
    '!artistOrCulture=true&geoLocation=Peru&q=quechua',
    'geoLocation=South%20America&q=inca', // 344
  ],
  WonderType.petra: [
    // -500 500
    '!artistOrCulture=true&q=nabataean', // 50
    '!geoLocation=Levant&q=levant', // 346
    'geoLocation=Asia&q=Arabia',
  ],
  WonderType.pyramidsGiza: [
    // -2600 -2500
    '!dateBegin=-2650&dateEnd=-2450&geoLocation=Egypt&q=egypt', // 205
    'geoLocation=Egypt&q=egypt', // 16668
  ],
  WonderType.tajMahal: [
    // 1600 1700
    '!geoLocation=India&q=mughal', // 399,
    'geoLocation=India&q=India',
  ],
};
