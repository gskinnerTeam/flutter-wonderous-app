import 'package:unsplash_client/unsplash_client.dart';
import 'package:wonders/logic/data/unsplash_photo_data.dart';

class UnsplashService {
  final client = UnsplashClient(
    settings: ClientSettings(
      credentials: AppCredentials(
        accessKey: 'aKxS07Q2KzFqUqpgM49xun75fFhPzCvY0bPoRlwwarU',
        secretKey: 'FRNh3y_J2Tu6Aa6ZZQcU3q6Fssm66GyZZxQx2ZbY7hk',
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
