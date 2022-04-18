import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';
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
    FlutterError.onError = _handleFlutterError;
    await settingsLogic.load();
    settingsLogic.scheduleSave(); // test save calls on each boot
    isBootstrapComplete = true;
    appRouter.go(ScreenPaths.home);
  }

  /// Walks user through flow to save a Wonder Poster to their gallery
  Future<void> saveWallpaper(BuildContext context, Widget widget, {required String name}) async {
    bool result = await showModal(context,
        child: OkCancelModal(
          msg: 'Save this poster to your photo gallery?',
          child: SizedBox(
            height: context.heightPct(.7),
            child: WallpaperPreview(child: widget),
          ),
        ));
    if (result) {
      showModal(context, child: LoadingModal(title: 'Saving Image. Please wait...'));
      await ScreenshotController().captureFromWidget(widget).then((Uint8List? image) async {
        if (image != null) {
          if (PlatformInfo.isMobile) {
            await ImageGallerySaver.saveImage(image, quality: 95, name: name);
          } else {
            await Future.delayed(500.ms);
          }
          Navigator.pop(context);
          showModal(context, child: OkModal(title: 'Save complete!'));
        }
      });
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

class FullscreenWebView extends StatelessWidget {
  const FullscreenWebView(this.url, {Key? key}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
        ),
      ),
    );
  }
}
