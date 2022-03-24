import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/unsplash_photo_data.dart';
import 'package:wonders/logic/unsplash_service.dart';

class UnsplashController {
  Map<String, UnsplashPhotoData> _imageInfoById = {};

  UnsplashService get service => GetIt.I.get<UnsplashService>();

  Future<UnsplashPhotoData?> getInfo(String id) async {
    if (!_imageInfoById.containsKey(id)) {
      final info = await service.loadInfo(id);
      if (info == null) return null; // If we couldn't load info, just exit now
      _imageInfoById[id] = info;
    }
    return _imageInfoById[id];
  }
}
