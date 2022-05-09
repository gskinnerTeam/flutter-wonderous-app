import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';
import 'package:wonders/ui/common/modals/fullscreen_web_view.dart';
import 'package:wonders/ui/modals/app_modals.dart';
import 'package:wonders/ui/screens/wallpaper_preview/wallpaper_preview.dart';

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

    // Load any bitmaps the views might need
    await AppBitmaps.init();

    // Settings load
    await settingsLogic.load();
    unawaited(settingsLogic.scheduleSave()); // test save calls on each boot

    // Collectibles
    await collectiblesLogic.load();

    // Load initial view and flag bootStrap as complete
    isBootstrapComplete = true;
    appRouter.go(ScreenPaths.home);
  }

  Future<Image?> takeScreenshot(RenderRepaintBoundary boundary) async {
    return null;
  }

  /// Walks user through flow to save a Wonder Poster to their gallery
  Future<void> saveWallpaper(BuildContext context, RenderRepaintBoundary boundary, {required String name}) async {
    // Time to create an image!
    ui.Image uiImage = await boundary.toImage();
    ByteData? byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();
      bool result = await showModal(context,
          child: OkCancelModal(
            msg: 'Save this poster to your photo gallery?',
          ));
      if (result) {
        showModal(context, child: LoadingModal(msg: 'Saving Image. Please wait...'));
        if (PlatformInfo.isMobile) {
          await ImageGallerySaver.saveImage(pngBytes, quality: 95, name: name);
        } else {
          await Future.delayed(500.ms);
        }
        Navigator.pop(context);
        showModal(context, child: OkModal(msg: 'Save complete!'));
      }
    }
  }

  void _handleFlutterError(FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  }

  /// TODO: talk to design team about whether we should link out or use an inline view.
  void showWebView(BuildContext context, String url) => Navigator.push(
        context,

        /// TODO: Switch from Cupertino to one of the "Animation" Page routes?
        CupertinoPageRoute(builder: (_) => FullscreenWebView(url)),
      );
}
