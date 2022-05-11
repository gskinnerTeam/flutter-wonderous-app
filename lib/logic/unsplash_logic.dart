import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/unsplash_photo_data.dart';
import 'package:wonders/logic/unsplash_service.dart';

class UnsplashLogic {
  final Map<String, List<String>> _idsByCollection = UnsplashPhotoData.photosByCollectionId;
  final Set<String> _preloadedUrls = {};

  UnsplashService get service => GetIt.I.get<UnsplashService>();

  List<String>? getCollectionPhotos(String collectionId) => _idsByCollection[collectionId];

  Future<void> preload(BuildContext context, String id, {required UnsplashPhotoSize size}) async {
    final url = UnsplashPhotoData.getSelfHostedUrl(id, size);
    // dont preload an image twice
    if (_preloadedUrls.contains(url)) return;
    // add url to cached list, so we'll ignore it next time
    _preloadedUrls.add(url);
    debugPrint('Preloading: $url');
    await precacheImage(NetworkImage(url), context);
  }
}
