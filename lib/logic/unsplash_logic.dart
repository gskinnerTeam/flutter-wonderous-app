import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/unsplash_photo_data.dart';
import 'package:wonders/logic/unsplash_service.dart';

class UnsplashLogic {
  final Map<String, UnsplashPhotoData> _imageInfoById = {};
  final Map<String, List<String>> _idsByCollection = {};
  final Set<String> _preloadedUrls = {};

  UnsplashService get service => GetIt.I.get<UnsplashService>();

  Future<UnsplashPhotoData?> getInfo(String id) async {
    if (!_imageInfoById.containsKey(id)) {
      final info = await service.loadInfo(id);
      if (info == null) return null; // If we couldn't load info, just exit now
      _imageInfoById[id] = info;
    }
    return _imageInfoById[id];
  }

  Future<List<String>?> getCollectionPhotos(String collectionId) async {
    final ids = await service.loadCollectionPhotos(collectionId);
    if (ids != null) {
      _idsByCollection[collectionId] = ids;
    }
    return ids;
  }

  Future<void> preload(BuildContext context, String id, {required UnsplashPhotoSize size}) async {
    final info = await getInfo(id);
    if (info != null) {
      final url = info.getSizedUrl(size);
      // dont preload an image twice
      if (_preloadedUrls.contains(url)) return;
      // add url to cached list, so we'll ignore it next time
      _preloadedUrls.add(url);
      debugPrint('Preloading: $url');
      await precacheImage(NetworkImage(url), context);
    }
  }
}
