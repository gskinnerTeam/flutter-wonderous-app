import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';

class AppBitmaps {
  static late final BitmapDescriptor mapMarker;

  static Future<void> init() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: PlatformInfo.dpi),
      '${ImagePaths.common}/location-pin.png',
    );
  }
}

/// Consolidate common paths used across the app
class ImagePaths {
  static String root = 'assets/images';
  static String common = 'assets/images/_common';
  static String cloud = '$common/cloud-white.png';

  static String collectibles = '$root/collectibles';
  static String collectibleIcons = '$collectibles/icons';
  static String sparkle = '$collectibles/sparkle_21x23.png';

  static String textures = '$common/texture';
  static String speckles = '$textures/speckles-white.png';
  static String roller1 = '$textures/roller-1-white.png';
  static String roller2 = '$textures/roller-2-white.png';
}

/// Place Svg paths in their own class, to hint to the views to use an SvgPicture to render
class SvgPaths {
  static String compassFull = '${ImagePaths.common}/compass-full.svg';
  static String compassSimple = '${ImagePaths.common}/compass-simple.svg';
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
