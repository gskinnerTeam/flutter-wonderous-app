import 'package:unsplash_client/unsplash_client.dart';
import 'package:wonders/keys.dart';
import 'package:wonders/logic/data/unsplash_photo_data.dart';

class UnsplashService {
  final client = UnsplashClient(
    settings: ClientSettings(
      credentials: AppCredentials(
        accessKey: unsplashAccessKey,
        secretKey: unsplashSecretKey,
      ),
    ),
  );

  Future<List<String>?> loadCollectionPhotos(String id) async {
    final photo = await client.collections.photos(id, page: 1, perPage: 25).go();
    final data = photo.data;
    if (data == null) return null;
    return data.map((e) => e.id).toList();
  }

  Future<UnsplashPhotoData?> loadInfo(String id) async {
    final photo = await client.photos.get(id).go();
    final data = photo.data;
    if (data == null) {
      throw ('Photo did not load. statusCode=${photo.statusCode}');
    }
    return UnsplashPhotoData(id: id, url: '${data.urls.raw}');
  }
}
