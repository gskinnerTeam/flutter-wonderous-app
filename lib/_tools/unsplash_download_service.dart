import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show get;
import 'package:path_provider/path_provider.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/unsplash_service.dart';
import 'package:wonders/logic/wonders_logic.dart';

class UnsplashDownloadService {
  static final UnsplashService _unsplash = UnsplashService();
  static final WondersLogic _wondersLogic = WondersLogic();

  /// Downloads one image in various sizes
  static Future<int> downloadImageSet(String id) async {
    final photo = await _unsplash.loadInfo(id);
    int saveCount = 0;
    if (photo != null) {
      final rootDir = await getApplicationDocumentsDirectory();
      final imagesDir = '${rootDir.path}/unsplash_images';
      await Directory(imagesDir).create(recursive: true);
      debugPrint('Downloading image set $id to $imagesDir');
      final sizes = [32, 400, 800, 2000, 1600, 4000];
      for (var size in sizes) {
        final url = photo.getUnsplashUrl(size);
        final imgResponse = await get(Uri.parse(url));
        File file = File('$imagesDir/$id-$size.jpg');
        file.writeAsBytesSync(imgResponse.bodyBytes);
        //print('file saved @ ${file.path}');
        saveCount++;
      }
    }
    return saveCount;
  }

  /// Downloads all images for a single collection, in various sizes
  static Future<void> downloadCollectionImages(WonderData data) async {
    final collection = await _unsplash.loadCollectionPhotos(data.unsplashCollectionId) ?? [];
    debugPrint('download: ${collection.length} images for ${data.title}');
    int downloadCount = 0;
    for (var p in collection) {
      downloadCount += await downloadImageSet(p);
    }
    debugPrint('${data.title} complete, downloads = $downloadCount');
  }

  /// Downloads all images for all collections
  static Future<void> downloadAllCollections() async {
    /// Note: intentionally not in parallel so as to not annoy the unsplash servers
    for (var w in _wondersLogic.all) {
      await downloadCollectionImages(w);
    }
  }

  /// Generates a map we can use to look up collection images without needing to copy all 200 ids by hand.
  /// Spits the results into the log, developers can copy and paste them from there into a dart file somewhere.
  static Future<void> printPhotosByCollectionIdMap() async {
    /// Note: intentionally not in parallel so as to not annoy the unsplash servers
    Map<String, List<String>> imageListByCollectionId = {};
    for (var w in _wondersLogic.all) {
      final collection = await _unsplash.loadCollectionPhotos(w.unsplashCollectionId) ?? [];
      imageListByCollectionId[w.unsplashCollectionId] = collection;
    }
    debugPrint('''
    final photosByCollectionId = ${jsonEncode(imageListByCollectionId).replaceAll('"', '\'')};
    ''');
  }
}
