import 'dart:async';
import 'dart:typed_data';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/utils/device_utils.dart';
import 'package:wonders/ui/modals/app_modals.dart';
import 'package:wonders/ui/screens/wallpaper_preview/wallpaper_preview.dart';

class AppController {
  /// Indicates to the rest of the app that bootstrap has not completed.
  /// The router will use this to prevent redirects while bootstrapping.
  bool isBootstrapComplete = false;

  /// The currently selected tab on the WonderDetails screen
  final selectedWondersTab = ValueNotifier(0);

  /// Initialize the app and all main actors.
  /// Loads settings, sets up services etc.
  Future<void> bootstrap() async {
    await settings.load();
    settings.scheduleSave(); // test save calls on each boot
    await wonders.init();
    isBootstrapComplete = true;
    // A43 - For testing search view
    // appRouter.go(ScreenPaths.home);
    appRouter.go(ScreenPaths.search(WonderType.petra));
  }

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
          if (DeviceUtils.isMobile) {
            await ImageGallerySaver.saveImage(image, quality: 95, name: name);
          } else {
            await Future.delayed(.5.seconds);
          }
          Navigator.pop(context);
          showModal(context, child: OkModal(title: 'Save complete!'));
        }
      });
    }
  }
}
