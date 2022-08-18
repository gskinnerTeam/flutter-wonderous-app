import 'dart:async';

import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/utils/page_routes.dart';

class AppLogic {
  /// Indicates to the rest of the app that bootstrap has not completed.
  /// The router will use this to prevent redirects while bootstrapping.
  bool isBootstrapComplete = false;

  /// The currently selected tab on the WonderDetails screen
  static const enablePersistentTabs = false;
  final selectedWondersTab = ValueNotifier(0);

  /// Initialize the app and all main actors.
  /// Loads settings, sets up services etc.
  Future<void> bootstrap() async {
    // Default error handler
    FlutterError.onError = _handleFlutterError;

    final futures = <Future>[];

    // Load any bitmaps the views might need
    futures.add(AppBitmaps.init());

    // Default to only allowing portrait mode
    setDeviceOrientation(Axis.vertical);

    // Localizations load
    await localeLogic.load();
    // Data load
    futures.add(timelineLogic.init());
    // Settings load
    futures.add(settingsLogic.load());
    unawaited(settingsLogic.scheduleSave()); // sanity check save calls on each boot
    // Collectibles init
    futures.add(collectiblesLogic.load());

    // Run all async operations concurrently
    await Future.wait(futures);

    // flag bootStrap as complete
    isBootstrapComplete = true;

    // load initial view (replace splash screen)
    if (settingsLogic.hasCompletedOnboarding.value) {
      appRouter.go(ScreenPaths.home);
    } else {
      appRouter.go(ScreenPaths.intro);
    }
  }

  void setDeviceOrientation(Axis? axis) {
    final orientations = <DeviceOrientation>[];
    if (axis == null || axis == Axis.vertical) {
      orientations.addAll([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    if (axis == null || axis == Axis.horizontal) {
      orientations.addAll([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    SystemChrome.setPreferredOrientations(orientations);
  }

  void _handleFlutterError(FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  }

  Future<T?> showFullscreenDialogRoute<T>(BuildContext context, Widget child) async {
    return await Navigator.of(context).push<T>(
      PageRoutes.dialog<T>(child, $styles.times.pageTransition),
    );
  }
}
