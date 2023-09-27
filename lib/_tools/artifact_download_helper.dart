import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wonders/logic/data/wonders_data/chichen_itza_data.dart';
import 'package:wonders/logic/data/wonders_data/christ_redeemer_data.dart';
import 'package:wonders/logic/data/wonders_data/great_wall_data.dart';
import 'package:wonders/logic/data/wonders_data/machu_picchu_data.dart';
import 'package:wonders/logic/data/wonders_data/petra_data.dart';
import 'package:wonders/logic/data/wonders_data/pyramids_giza_data.dart';
import 'package:wonders/logic/data/wonders_data/taj_mahal_data.dart';

import '../common_libs.dart';
import '../logic/data/collectible_data.dart';
import '../logic/data/wonders_data/colosseum_data.dart';

class ArtifactDownloadHelper extends StatefulWidget {
  const ArtifactDownloadHelper({super.key});

  @override
  State<ArtifactDownloadHelper> createState() => _ArtifactDownloadHelperState();
}

/// Using collectiblesData fetch the data for each artifact and download the image.
/// Resize all images to have multiple sizes (small, medium, large)
/// Save images using format [ID].jpg and [ID].json
/// OR modify CollectibleData_helper.html to include all data in the collectiblesData list so no JSON is required.
class _ArtifactDownloadHelperState extends State<ArtifactDownloadHelper> {
  late String imagesDir;
  final http = Client();
  final List<String> missingIds = [];

  @override
  void initState() {
    super.initState();
    createDirectory();
  }

  Future<void> createDirectory() async {
    final rootDir = await getApplicationDocumentsDirectory();
    imagesDir = '${rootDir.path}/met_collectibles';
    await Directory(imagesDir).create(recursive: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: downloadArtifacts,
        child: Text('Download Artifacts'),
      ),
    );
  }

  Future<bool> downloadImage(String id, String url) async {
    //final sizes = [400, 800, 1600, 3000];
    debugPrint('Downloading $url to $imagesDir');
    final imgResponse = await get(Uri.parse(url));
    // If the image is less than a KB, it's probably a 404 image.
    if (imgResponse.bodyBytes.lengthInBytes < 2000) {
      return false;
    }
    File file = File('$imagesDir/$id.jpg');
    file.writeAsBytesSync(imgResponse.bodyBytes);
    print('img saved @ ${file.path}');
    return true;
  }

  Future<void> downloadImageAndJson(String id) async {
    File imgFile = File('$imagesDir/$id.jpg');
    if (imgFile.existsSync()) {
      print('Skipping $id');
      await resizeImage(id, 600);
      return;
    }
    Uri uri = Uri.parse('https://collectionapi.metmuseum.org/public/collection/v1/objects/$id');
    print('Downloading $id');
    final response = await http.get(uri);
    Map json = jsonDecode(response.body) as Map;
    if (!json.containsKey('primaryImage') || json['primaryImage'].isEmpty) {
      print('Missing $id');
      missingIds.add(id);
      return;
    }
    final url = json['primaryImage'] as String;
    //bool isPublicDomain = json['isPublicDomain'] as bool;
    final downloadSuccess = await downloadImage(id, url);
    if (downloadSuccess) {
      File file = File('$imagesDir/$id.json');
      file.writeAsStringSync(response.body);
      print('json saved @ ${file.path}');
    } else {
      print('Missing $id');
      missingIds.add(id);
    }
  }

  void downloadArtifacts() async {
    /// Download collectibles
    // for (var c in collectiblesData) {
    //   downloadImageAndJson(c.artifactId);
    // }
    missingIds.clear();

    /// Download search artifacts
    final searchData = ChichenItzaData().searchData +
        ChristRedeemerData().searchData +
        ColosseumData().searchData +
        GreatWallData().searchData +
        MachuPicchuData().searchData +
        PetraData().searchData +
        PyramidsGizaData().searchData +
        TajMahalData().searchData;
    for (var a in searchData) {
      await downloadImageAndJson(a.id.toString());
      print('${searchData.indexOf(a) + 1}/${searchData.length}');
    }
    print('Missing IDs: $missingIds');
  }

  Future<void> resizeImage(String id, int size) async {
    final resizedFile = File('$imagesDir/${id}_$size.jpg');
    final srcFile = File('$imagesDir/$id.jpg');
    print('Resizing $id...');
    if (resizedFile.existsSync() || !srcFile.existsSync()) return;
    final img = decodeJpg(srcFile.readAsBytesSync());
    if (img != null) {
      final resizedImg = copyResize(img, width: size);
      resizedFile.writeAsBytesSync(encodeJpg(resizedImg));
      print('Resized $id');
    } else {
      print('Failed to resize $id');
    }
  }
}
