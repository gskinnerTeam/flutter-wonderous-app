import 'package:unsplash_client/unsplash_client.dart';

final client = UnsplashClient(
  settings: ClientSettings(
      credentials: AppCredentials(
    accessKey: '...',
    secretKey: '...',
  )),
);
