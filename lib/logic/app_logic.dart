import 'dart:async';
import 'dart:ui';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';
import 'package:wonders/ui/common/modals/fullscreen_video_viewer.dart';
import 'package:wonders/ui/common/utils/page_routes.dart';

class AppLogic {
  Size _appSize = Size.zero;

  /// Indicates to the rest of the app that bootstrap has not completed.
  /// The router will use this to prevent redirects while bootstrapping.
  bool isBootstrapComplete = false;

  /// Indicates which orientations the app will allow be default. Affects Android/iOS devices only.
  /// Defaults to both landscape (hz) and portrait (vt)
  List<Axis> supportedOrientations = [Axis.vertical, Axis.horizontal];

  /// Allow a view to override the currently supported orientations. For example, [FullscreenVideoViewer] always wants to enable both landscape and portrait.
  /// If a view sets this override, they are responsible for setting it back to null when finished.
  List<Axis>? _supportedOrientationsOverride;
  set supportedOrientationsOverride(List<Axis>? value) {
    if (_supportedOrientationsOverride != value) {
      _supportedOrientationsOverride = value;
      _updateSystemOrientation();
    }
  }

  /// Initialize the app and all main actors.
  /// Loads settings, sets up services etc.
  Future<void> bootstrap() async {
    debugPrint('bootstrap start...');
    // Set min-sizes for desktop apps
    // TODO: Test on Linux and confirm whether it's safe to call there, according to issue #183 its not.
    if (!kIsWeb && (PlatformInfo.isWindows || PlatformInfo.isMacOS)) {
      await DesktopWindow.setMinWindowSize($styles.sizes.minAppSize);
    }

    if (kIsWeb) {
      // SB: This is intentionally not a debugPrint, as it's a message for users who open the console on web.
      print(
        '''Thanks for checking out Wonderous on the web!
        If you encounter any issues please report them at https://github.com/gskinnerTeam/flutter-wonderous-app/issues.''',
      );
      // Required on web to automatically enable accessibility features
      WidgetsFlutterBinding.ensureInitialized().ensureSemantics();
    }

    // Load any bitmaps the views might need
    await AppBitmaps.init();

    // Set preferred refresh rate to the max possible (the OS may ignore this)
    if (!kIsWeb && PlatformInfo.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }

    // Settings
    await settingsLogic.load();

    // Localizations
    await localeLogic.load();

    // Wonders Data
    wondersLogic.init();

    // Events
    timelineLogic.init();

    // Collectibles
    collectiblesLogic.init();
    await collectiblesLogic.load();

    // Wait at least 1 frame to give GoRouter time to catch the initial deeplink
    await Future.delayed(1.milliseconds);

    // Flag bootStrap as complete
    isBootstrapComplete = true;

    // Load initial view (replace empty initial view which is covered by a native splash screen)
    bool showIntro = settingsLogic.hasCompletedOnboarding.value == false;
    if (showIntro) {
      appRouter.go(ScreenPaths.intro);
    } else {
      appRouter.go(initialDeeplink ?? ScreenPaths.home);
    }
  }

  Future<T?> showFullscreenDialogRoute<T>(BuildContext context, Widget child, {bool transparent = false}) async {
    return await Navigator.of(context).push<T>(
      PageRoutes.dialog<T>(child, duration: $styles.times.pageTransition),
    );
  }

  /// Called from the UI layer once a MediaQuery has been obtained
  void handleAppSizeChanged(Size appSize) {
    /// Disable landscape layout on smaller form factors
    bool isSmall = display.size.shortestSide / display.devicePixelRatio < 600;
    supportedOrientations = isSmall ? [Axis.vertical] : [Axis.vertical, Axis.horizontal];
    _updateSystemOrientation();
    _appSize = appSize;
  }

  Display get display => PlatformDispatcher.instance.displays.first;

  bool shouldUseNavRail() => _appSize.width > _appSize.height && _appSize.height > 250;

  void _updateSystemOrientation() {
    final axisList = _supportedOrientationsOverride ?? supportedOrientations;
    //debugPrint('updateDeviceOrientation, supportedAxis: $axisList');
    final orientations = <DeviceOrientation>[];
    if (axisList.contains(Axis.vertical)) {
      orientations.addAll([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    if (axisList.contains(Axis.horizontal)) {
      orientations.addAll([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    SystemChrome.setPreferredOrientations(orientations);
  }

  void precacheUrl(String url, BuildContext context) async {
    await precacheImage(AssetImage(url), context, onError: (error, stackTrace) {
      print('Loading $url failed - ${error.toString()}');
    });
  }

  void precacheIcons(BuildContext context) {
    // Precache the active and idle icons for the navigation bar.
    List<String> urls = [];
    for (var i = 0; i < 2; i++) {
      urls.add('${ImagePaths.common}/tab-editorial${i == 0 ? '-active' : ''}.png');
      urls.add('${ImagePaths.common}/tab-photos${i == 0 ? '-active' : ''}.png');
      urls.add('${ImagePaths.common}/tab-artifacts${i == 0 ? '-active' : ''}.png');
      urls.add('${ImagePaths.common}/tab-timeline${i == 0 ? '-active' : ''}.png');
    }
    for (var url in urls) {
      precacheUrl(url, context);
    }
  }

  void precacheWonderImages(BuildContext context) {
    List<String> urls = [
      '${ImagePaths.root}/chichen_itza/chichen.png',
      '${ImagePaths.root}/chichen_itza/foreground-left.png',
      '${ImagePaths.root}/chichen_itza/foreground-right.png',
      '${ImagePaths.root}/chichen_itza/top-left.png',
      '${ImagePaths.root}/chichen_itza/top-right.png',
      '${ImagePaths.root}/chichen_itza/sun.png',
      '${ImagePaths.root}/christ_the_redeemer/redeemer.png',
      '${ImagePaths.root}/christ_the_redeemer/foreground-left.png',
      '${ImagePaths.root}/christ_the_redeemer/foreground-right.png',
      '${ImagePaths.root}/christ_the_redeemer/sun.png',
      '${ImagePaths.root}/colosseum/colosseum.png',
      '${ImagePaths.root}/colosseum/foreground-left.png',
      '${ImagePaths.root}/colosseum/foreground-right.png',
      '${ImagePaths.root}/colosseum/sun.png',
      '${ImagePaths.root}/great_wall_of_china/great-wall.png',
      '${ImagePaths.root}/great_wall_of_china/foreground-left.png',
      '${ImagePaths.root}/great_wall_of_china/foreground-right.png',
      '${ImagePaths.root}/great_wall_of_china/sun.png',
      '${ImagePaths.root}/machu_picchu/machu-picchu.png',
      '${ImagePaths.root}/machu_picchu/foreground-back.png',
      '${ImagePaths.root}/machu_picchu/foreground-front.png',
      '${ImagePaths.root}/machu_picchu/sun.png',
      '${ImagePaths.root}/petra/petra.png',
      '${ImagePaths.root}/petra/foreground-left.png',
      '${ImagePaths.root}/petra/foreground-right.png',
      '${ImagePaths.root}/petra/moon.png',
      '${ImagePaths.root}/pyramids/pyramids.png',
      '${ImagePaths.root}/pyramids/foreground-back.png',
      '${ImagePaths.root}/pyramids/foreground-front.png',
      '${ImagePaths.root}/pyramids/moon.png',
      '${ImagePaths.root}/taj_mahal/taj-mahal.png',
      '${ImagePaths.root}/taj_mahal/foreground-left.png',
      '${ImagePaths.root}/taj_mahal/foreground-right.png',
      '${ImagePaths.root}/taj_mahal/sun.png',
      '${ImagePaths.root}/taj_mahal/pool.png',
    ];
    List<String> folderNames = [
      'chichen_itza',
      'christ_the_redeemer',
      'colosseum',
      'great_wall_of_china',
      'machu_picchu',
      'petra',
      'pyramids',
      'taj_mahal'
    ];

    // Universals.
    for (var name in folderNames) {
      urls.add('${ImagePaths.root}/$name/flattened.jpg');
      urls.add('${ImagePaths.root}/$name/wonder-button.png');
      urls.add('${ImagePaths.root}/$name/photo-1.jpg');
      urls.add('${ImagePaths.root}/$name/photo-2.jpg');
      urls.add('${ImagePaths.root}/$name/photo-3.jpg');
      urls.add('${ImagePaths.root}/$name/photo-4.jpg');
    }

    for (var url in urls) {
      precacheUrl(url, context);
    }
  }
}

class AppImageCache extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() {
    this.imageCache.maximumSizeBytes = 250 << 20; // 250mb
    return super.createImageCache();
  }
}
