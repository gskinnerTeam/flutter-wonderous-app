import 'package:wonders/common_libs.dart';

/// Consolidate common paths uses across the app
class ImagePaths {
  static String root = 'assets/images';
  static String cloud = '$root/cloud-white.png';

  static String collectibles = '$root/collectibles';
  static String collectibleIcons = '$collectibles/icons';
  static String sparkle = '$collectibles/sparkle_21x23.png';

  static String textures = '$root/texture';
  static String speckles = '$textures/speckles-white.png';
  static String roller1 = '$textures/roller-1-white.png';
  static String roller2 = '$textures/roller-2-white.png';
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
      case WonderType.pyramidsGiza:
        return '${ImagePaths.root}/pyramids_giza';
      case WonderType.greatWall:
        return '${ImagePaths.root}/great_wall';
      case WonderType.petra:
        return '${ImagePaths.root}/petra';
      case WonderType.colosseum:
        return '${ImagePaths.root}/colosseum';
      case WonderType.chichenItza:
        return '${ImagePaths.root}/chichen_itza';
      case WonderType.machuPicchu:
        return '${ImagePaths.root}/machu_picchu';
      case WonderType.tajMahal:
        return '${ImagePaths.root}/taj_mahal';
      case WonderType.christRedeemer:
        return '${ImagePaths.root}/christ_redeemer';
    }
  }

  String get photo1 => '$assetPath/photo-1.jpg';
  String get photo2 => '$assetPath/photo-2.jpg';
  String get photo3 => '$assetPath/photo-3.jpg';
  String get photo4 => '$assetPath/photo-4.jpg';
}
