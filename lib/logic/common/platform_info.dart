import 'package:flutter/foundation.dart';

class PlatformInfo {
  static const _desktopPlatforms = [TargetPlatform.macOS, TargetPlatform.windows, TargetPlatform.linux];
  static const _mobilePlatforms = [TargetPlatform.android, TargetPlatform.iOS];

  static bool get isDesktop => _desktopPlatforms.contains(defaultTargetPlatform);
  static bool get isMobile => _mobilePlatforms.contains(defaultTargetPlatform);

  static bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;
  static bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;
  static bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;
  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;
}
