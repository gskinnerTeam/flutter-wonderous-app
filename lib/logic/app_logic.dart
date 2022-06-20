import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';
import 'package:wonders/ui/common/utils/page_routes.dart';
import 'package:wonders/ui/modals/app_modals.dart';
import 'package:wonders/ui/spikes/accessibility_spike.dart';

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

    //
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Settings load
    await settingsLogic.load();
    unawaited(settingsLogic.scheduleSave()); // test save calls on each boot

    // Collectibles
    await collectiblesLogic.load();

    // Load initial view and flag bootStrap as complete
    isBootstrapComplete = true;

    if (settingsLogic.hasCompletedOnboarding.value) {
      appRouter.go(ScreenPaths.home);
    } else {
      appRouter.go(ScreenPaths.intro);
    }
  }

  /// TODO: Move all the wallpaper stuff to some WallPaperLogic class?
  /// Walks user through flow to save a Wonder Poster to their gallery
  Future<void> saveWallpaper(State state, RenderRepaintBoundary boundary, {required String name}) async {
    // Time to create an image!
    Uint8List? pngBytes = await _getPngFromBoundary(boundary);
    final context = state.context, mounted = state.mounted;
    if (pngBytes != null && mounted) {
      bool? result = await showModal(context,
          child: OkCancelModal(
            msg: 'Save this poster to your photo gallery?',
          ));
      if (result == true && mounted) {
        showModal(context, child: LoadingModal(msg: 'Saving Image. Please wait...'));
        if (PlatformInfo.isMobile) {
          await ImageGallerySaver.saveImage(pngBytes, quality: 95, name: name);
        } else {
          await Future.delayed(500.ms);
        }
        if (state.mounted) {
          Navigator.pop(context);
          showModal(context, child: OkModal(msg: 'Save complete!'));
        }
      }
    }
  }

  Future<void> shareWallpaper(BuildContext context, RenderRepaintBoundary boundary,
      {required String name, String wonderName = 'Wonderous'}) async {
    Uint8List? pngBytes = await _getPngFromBoundary(boundary);
    if (pngBytes != null) {
      final directory = (await getApplicationDocumentsDirectory()).path;
      File imgFile = File('$directory/$name.png');
      await imgFile.writeAsBytes(pngBytes);
      Share.shareFiles([imgFile.path],
          mimeTypes: ['image/png'],
          subject: '$wonderName Wallpaper',
          text: 'Check out this $wonderName wallpaper from the Wonderous app!');
    }
  }

  Future<Uint8List?> _getPngFromBoundary(RenderRepaintBoundary boundary) async {
    ui.Image uiImage = await boundary.toImage();
    ByteData? byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      return byteData.buffer.asUint8List();
    }
    return null;
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
