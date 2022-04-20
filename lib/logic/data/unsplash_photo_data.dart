import 'package:wonders/logic/common/platform_info.dart';

enum UnsplashPhotoSize { small, med, large, xl }

class UnsplashPhotoData {
  static const String unsplashUrl = 'https://unsplash.com/?utm_source=wonders&utm_medium=referral';
  UnsplashPhotoData({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.ownerName,
    required this.ownerUsername,
  });
  final String id;
  final int width;
  final int height;
  final String url;
  final String ownerName;
  final String ownerUsername;
  late final double aspect = width / height;

  late final String photographerUrl = 'https://unsplash.com/@$ownerUsername?utm_source=wonders&utm_medium=referral';

  String getSizedUrl(UnsplashPhotoSize targetSize) {
    late int size;
    switch (targetSize) {
      case UnsplashPhotoSize.small:
        size = 200;
        break;
      case UnsplashPhotoSize.med:
        size = 600;
        break;
      case UnsplashPhotoSize.large:
        size = 800;
        break;
      case UnsplashPhotoSize.xl:
        size = 1200;
        break;
    }
    size = (size * PlatformInfo.dpi.clamp(1, 2)).round();

    return '$url?q=85&fm=jpg&w=$size&fit=max';
  }
}
