import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';
import 'package:wonders/ui/common/modals/app_modals.dart';

class WallPaperLogic {
  /// Walks user through flow to save a Wonder Poster to their gallery
  Future<void> save(State state, RenderRepaintBoundary boundary, {required String name}) async {
    // Time to create an image!
    Uint8List? pngBytes = await _getPngFromBoundary(boundary);
    final context = state.context, mounted = state.mounted;
    if (pngBytes != null && mounted) {
      bool? result = await showModal(context,
          child: OkCancelModal(
            msg: $strings.wallpaperModalSave,
          ));
      if (result == true && mounted) {
        showModal(context, child: LoadingModal(msg: $strings.wallpaperModalSaving));
        if (PlatformInfo.isMobile) {
          await ImageGallerySaver.saveImage(pngBytes, quality: 95, name: name);
        } else {
          await Future.delayed(500.ms);
        }
        if (state.mounted) {
          Navigator.pop(context);
          showModal(context, child: OkModal(msg: $strings.wallpaperModalSaveComplete));
        }
      }
    }
  }

  Future<void> share(BuildContext context, RenderRepaintBoundary boundary,
      {required String name, String wonderName = 'Wonderous'}) async {
    Uint8List? pngBytes = await _getPngFromBoundary(boundary);
    if (pngBytes != null) {
      final directory = (await getApplicationDocumentsDirectory()).path;
      File imgFile = File('$directory/$name.png');
      await imgFile.writeAsBytes(pngBytes);
      Share.shareXFiles([XFile(imgFile.path)],
          subject: '$wonderName Wallpaper', text: 'Check out this $wonderName wallpaper from the Wonderous app!');
    }
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
