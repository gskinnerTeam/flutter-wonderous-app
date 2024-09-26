import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/logic/data/highlight_data.dart';
import 'package:wonders/logic/data/wonders_data/chichen_itza_data.dart';
import 'package:wonders/logic/data/wonders_data/christ_redeemer_data.dart';
import 'package:wonders/logic/data/wonders_data/colosseum_data.dart';
import 'package:wonders/logic/data/wonders_data/great_wall_data.dart';
import 'package:wonders/logic/data/wonders_data/machu_picchu_data.dart';
import 'package:wonders/logic/data/wonders_data/petra_data.dart';
import 'package:wonders/logic/data/wonders_data/pyramids_giza_data.dart';
import 'package:wonders/logic/data/wonders_data/taj_mahal_data.dart';

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

  void downloadArtifacts() async {
    missingIds.clear();

    /// Download collectibles
    for (var c in collectiblesData) {
      if (await downloadImageAndJson(c.artifactId) == false) {
        missingIds.add(c.artifactId);
      }
    }

    /// Download Highights
    for (var h in HighlightData.all) {
      if (await downloadImageAndJson(h.artifactId) == false) {
        missingIds.add(h.artifactId);
      }
    }

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
      final id = a.id.toString();
      if (await downloadImageAndJson(id) == false) {
        missingIds.add(id);
      }
      final index = searchData.indexOf(a) + 1;
      if (index % 100 == 0) {
        debugPrint('$index/${searchData.length}');
      }
    }
    debugPrint('Download complete :) Missing IDs: $missingIds');
  }

  Future<bool> downloadImageAndJson(String id) async {
    File jsonFile = File('$imagesDir/$id.json');
    late Map json;
    if (jsonFile.existsSync()) {
      json = jsonDecode(jsonFile.readAsStringSync()) as Map;
    } else {
      debugPrint('Downloading $id');
      // Fetch JSON for id
      Uri uri = Uri.parse('https://collectionapi.metmuseum.org/public/collection/v1/objects/$id');
      final response = await http.get(uri);
      json = jsonDecode(response.body) as Map;
    }

    // Check if primaryImage field is valid
    if (!json.containsKey('primaryImage') || json['primaryImage'].isEmpty) {
      return false;
    }
    // Download image
    final url = json['primaryImage'] as String;
    //bool isPublicDomain = json['isPublicDomain'] as bool;
    File imgFile = File('$imagesDir/$id.jpg');
    // If image does not already exist, download it
    if (!imgFile.existsSync()) {
      await downloadImage(id, url);
      if (!imgFile.existsSync()) return false;
    }
    // Try to resize image
    if (await resizeImage(id, [600, 2000]) == false) {
      debugPrint('Failed to resize $id');
      imgFile.deleteSync();
      return false;
    }
    // Write JSON to file
    if (!jsonFile.existsSync()) {
      jsonFile.writeAsStringSync(jsonEncode(json));
      debugPrint('json saved @ ${jsonFile.path}');
    }
    return true;
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
    debugPrint('img saved @ ${file.path}');
    return true;
  }

  Future<bool> resizeImage(String id, List<int> sizes) async {
    final srcFile = File('$imagesDir/$id.jpg');
    //debugPrint('Resizing $id...');
    try {
      final img = decodeJpg(srcFile.readAsBytesSync());
      if (img != null) {
        // Write various sizes to disk
        for (var size in sizes) {
          final resizedFile = File('$imagesDir/${id}_$size.jpg');
          if (await resizedFile.exists()) continue;
          final resizedImg = copyResize(img, width: size);
          await resizedFile.writeAsBytes(encodeJpg(resizedImg, quality: 90));
          debugPrint('Resized ${id}_$size');
        }
        return true;
      }
    } catch (e) {
      debugPrint('Failed to resize $id');
      debugPrint(e.toString());
    }
    return false;
  }
}
