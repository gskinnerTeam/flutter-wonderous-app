import 'dart:async';

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';

class AppController {
  /// Indicates to the rest of the app that bootstrap has not completed.
  /// The router will use this to prevent redirects while bootstrapping.
  bool isBootstrapComplete = false;

  /// The current global style of the app.
  // final style = ValueNotifier<AppStyles>(AppStyles(scale: 1, colors: DefaultColorTheme()));

  /// Initialize the app and all main actors.
  /// Loads settings, sets up services etc.
  Future<void> bootstrap() async {
    await settings.load();
    settings.scheduleSave(); // test save calls on each boot
    await wonders.init();
    isBootstrapComplete = true;
    appRouter.go(ScreenPaths.home);
  }
}
