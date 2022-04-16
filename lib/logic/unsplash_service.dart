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

  Future<UnsplashPhotoData?> loadInfo(String id) async {
    final photo = await client.photos.get(id).go();
    final data = photo.data;
    if (data == null) return null;
    return UnsplashPhotoData(
        id: id,
        width: data.width,
        height: data.height,
        url: '${data.urls.raw}',
        ownerName: data.user.name,
        ownerUsername: data.user.username);
  }
}
