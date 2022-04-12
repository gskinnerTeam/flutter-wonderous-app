import 'package:wonders/common_libs.dart';

/// Consolidate common paths uses across the app
class ImagePaths {
  static String root = 'assets/images';
  static String collectibles = '$root/collectibles';
  static String cloud = '$root/cloud-white.png';
  static String speckles = '$root/texture/speckles-white.png';
  static String roller1 = '$root/texture/roller-1-white.png';
  static String roller2 = '$root/texture/roller-2-white.png';
}

/// Place Svg paths in their own class, to hint to the views to use an SvgPicture to render
/// Access with `AssetPaths.svg.foo`
class SvgPaths {
  static String compassFull = '${ImagePaths.root}/compass-full.svg';
  static String compassSimple = '${ImagePaths.root}/compass-simple.svg';
}

/// For wonder specific assets, add an extension to [WonderType] for easy lookup
extension WonderAssetExtensions on WonderType {
  String get assetPath {
    switch (this) {
      case WonderType.tajMahal:
        return '${ImagePaths.root}/taj_mahal';
      case WonderType.chichenItza:
        return '${ImagePaths.root}/chichen_itza';
    }
  }

  String get photo1 => '$assetPath/photo-1.jpg';
  String get photo2 => '$assetPath/photo-2.jpg';
  String get photo3 => '$assetPath/photo-3.jpg';
  String get photo4 => '$assetPath/photo-4.jpg';
}
