import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wonders/common_libs.dart';

class PlatformInfo {
  static const _desktopPlatforms = [TargetPlatform.macOS, TargetPlatform.windows, TargetPlatform.linux];
  static const _mobilePlatforms = [TargetPlatform.android, TargetPlatform.iOS];

  static bool get isDesktop => _desktopPlatforms.contains(defaultTargetPlatform);
  static bool get isDesktopOrWeb => isDesktop || kIsWeb;
  static bool get isMobile => _mobilePlatforms.contains(defaultTargetPlatform);

  static double get pixelRatio => WidgetsBinding.instance.window.devicePixelRatio;

  static bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;
  static bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;
  static bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;
  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  static Future<bool> get isConnected async => await InternetConnectionChecker().hasConnection;
  static Future<bool> get isDisconnected async => (await isConnected) == false;
}
