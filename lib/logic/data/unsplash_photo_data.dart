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
      case UnsplashPhotoSize.med:
        size = 400;
        break;
      case UnsplashPhotoSize.large:
        size = 800;
        break;
      case UnsplashPhotoSize.xl:
        size = 1200;
        break;
    }
    if (PlatformInfo.pixelRatio >= 1.5) {
      size *= 2;
    }
    //return 'http://wonderous.info/test_$size.jpg';
    return '$url?q=90&fm=jpg&w=$size&fit=max';
  }
}
