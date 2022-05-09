import 'dart:io';

import 'package:http/http.dart' show get;
import 'package:path_provider/path_provider.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/chichen_itza_data.dart';
import 'package:wonders/logic/data/wonders_data/christ_redeemer_data.dart';
import 'package:wonders/logic/data/wonders_data/colosseum_data.dart';
import 'package:wonders/logic/data/wonders_data/great_wall_data.dart';
import 'package:wonders/logic/data/wonders_data/machu_picchu_data.dart';
import 'package:wonders/logic/data/wonders_data/petra_data.dart';
import 'package:wonders/logic/data/wonders_data/pyramids_giza_data.dart';
import 'package:wonders/logic/data/wonders_data/taj_mahal_data.dart';
import 'package:wonders/logic/unsplash_service.dart';

class UnsplashDownloadService {
  static UnsplashService _unsplash = UnsplashService();

  /// Downloads one image in various sizes
  static Future<int> downloadImageSet(String id) async {
    final photo = await _unsplash.loadInfo(id);
    int saveCount = 0;
    if (photo != null) {
      final sizes = [32, 400, 800, 1200, 1600, 2400];
      for (var size in sizes) {
        final url = photo.getExactSizeUrl(size);
        final imgResponse = await get(Uri.parse(url));
        final rootDir = await getApplicationDocumentsDirectory();
        final imagesDir = rootDir.path + '/unsplash_images';
        await Directory(imagesDir).create(recursive: true);
        File file = File('$imagesDir/$id-$size.jpg');
        file.writeAsBytesSync(imgResponse.bodyBytes);
        //print('file saved @ ${file.path}');
        saveCount++;
      }
    }
    return saveCount;
  }

  static Future<void> downloadCollectionImages(WonderData data) async {
    final collection = await _unsplash.loadCollectionPhotos(data.unsplashCollectionId) ?? [];
    print('download: ${collection.length} images for ${data.title}');
    int downloadCount = 0;
    for (var p in collection) {
      downloadCount += await downloadImageSet(p);
    }
    print('${data.title} complete, downloads = $downloadCount');
  }

  Future<void> downloadAllCollections() async {
    /// Note: intentionally not in parallel
    await downloadCollectionImages(petraData);
    await downloadCollectionImages(chichenItzaData);
    await downloadCollectionImages(machuPicchuData);
    await downloadCollectionImages(colosseumData);
    await downloadCollectionImages(tajMahalData);
    await downloadCollectionImages(pyramidsGizaData);
    await downloadCollectionImages(christRedeemerData);
    await downloadCollectionImages(greatWallData);
  }
}
