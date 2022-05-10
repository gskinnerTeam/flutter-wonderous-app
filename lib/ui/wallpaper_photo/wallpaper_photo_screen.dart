import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/controls/checkbox.dart';
import 'package:wonders/ui/wonder_illustrations/common/animated_clouds.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_title_text.dart';

class WallpaperPhotoScreen extends StatefulWidget {
  const WallpaperPhotoScreen({Key? key, required this.type}) : super(key: key);
  final WonderType type;

  @override
  State<WallpaperPhotoScreen> createState() => _WallpaperPhotoScreenState();
}

class _WallpaperPhotoScreenState extends State<WallpaperPhotoScreen> {
  final GlobalKey _containerKey = GlobalKey();
  Widget? _illustration;

  bool _isTextOn = true;
  bool _isNightOn = false;
  Timer? _photoRetryTimer;

  @override
  void dispose() {
    _photoRetryTimer?.cancel();
    super.dispose();
  }

  void _handleTakePhoto(BuildContext context, String wonderName) async {
    RenderRepaintBoundary boundary = _containerKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    if (boundary.debugNeedsPaint) {
      _photoRetryTimer = Timer(Duration(milliseconds: 1), () => _handleTakePhoto(context, wonderName));
      return;
    }

    appLogic.saveWallpaper(context, boundary, name: '${wonderName}_wallpaper');
  }

  void _handleSharePhoto(BuildContext context, String wonderName) async {
    RenderRepaintBoundary boundary = _containerKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    if (boundary.debugNeedsPaint) {
      _photoRetryTimer = Timer(Duration(milliseconds: 1), () => _handleTakePhoto(context, wonderName));
      return;
    }

    appLogic.shareWallpaper(context, boundary, name: '${wonderName}_wallpaper', wonderName: wonderName);
  }

  void _handleTextToggle(bool? isActive) {
    setState(() => _isTextOn = isActive ?? !_isNightOn);
  }

  void _handleNightToggle(bool isActive) {
    setState(() => _isNightOn = isActive);
  }

  @override
  Widget build(BuildContext context) {
    WonderData wonderData = wondersLogic.getData(widget.type);
    WonderIllustrationConfig bgConfig = WonderIllustrationConfig.bg(
      enableAnims: false,
      enableHero: false,
    );
    WonderIllustrationConfig mgConfig = WonderIllustrationConfig.mg(
      enableAnims: false,
      enableHero: false,
    );
    WonderIllustrationConfig fgConfig = WonderIllustrationConfig.fg(
      enableAnims: false,
      enableHero: false,
    );

    Color fgColor = wonderData.type.bgColor; //.withOpacity(.5);

    if (_isNightOn) {
      _illustration = RepaintBoundary(
        key: _containerKey,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(Color(0xFF4000FF), BlendMode.multiply),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.xor),
            child: Stack(
              children: [
                // Background - apply additional filter to make moon brighter
                ColorFiltered(
                  colorFilter: ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.difference),
                  child: WonderIllustration(
                    widget.type,
                    config: bgConfig,
                  ),
                ),
                // Clouds
                FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: .5,
                  child: AnimatedClouds(
                    wonderType: wonderData.type,
                    opacity: 1,
                    enableAnimations: false,
                  ),
                ),
                // Wonder illustration
                WonderIllustration(
                  widget.type,
                  config: mgConfig,
                ),
                // Plants and foreground stuff
                WonderIllustration(
                  widget.type,
                  config: fgConfig,
                ),
                // Foreground gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        fgColor.withOpacity(0),
                        fgColor.withOpacity(fgColor.opacity * .75),
                      ],
                      stops: const [0, 1],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      _illustration = RepaintBoundary(
        key: _containerKey,
        child: Stack(
          children: [
            // Background - apply additional filter to make moon brighter
            WonderIllustration(
              widget.type,
              config: bgConfig,
            ),

            // Clouds
            FractionallySizedBox(
              widthFactor: 1,
              heightFactor: .5,
              child: AnimatedClouds(
                wonderType: wonderData.type,
                opacity: 1,
                enableAnimations: false,
              ),
            ),

            // Wonder illustration
            WonderIllustration(
              widget.type,
              config: mgConfig,
            ),

            // Plants and foreground stuff
            WonderIllustration(
              widget.type,
              config: fgConfig,
            ),

            // Foreground gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    fgColor.withOpacity(0),
                    fgColor.withOpacity(fgColor.opacity * .75),
                  ],
                  stops: const [0, 1],
                ),
              ),
            ),

            // Title text
            if (_isTextOn)
              BottomCenter(
                child: Transform.translate(
                  offset: Offset(0.0, -context.insets.xl * 2),
                  child: WonderTitleText(wonderData, enableShadows: true),
                ),
              ),
          ],
        ),
      );
    }

    return AspectRatio(
      aspectRatio: context.widthPx / context.heightPx,
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(backgroundBlendMode: BlendMode.color, color: Colors.blue),
          child: _illustration ?? Container(),
        ),
        TopCenter(
          child: Padding(
            padding: EdgeInsets.all(context.insets.md),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: BackBtn.close(
                    bgColor: context.colors.offWhite,
                    iconColor: context.colors.black,
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 16.0),
                  child: CircleIconBtn(
                    icon: Icons.share,
                    bgColor: context.colors.offWhite,
                    color: context.colors.black,
                    onPressed: () => _handleSharePhoto(context, wonderData.title),
                    semanticLabel: 'share photo',
                    size: 44,
                  ),
                ),
                CircleIconBtn(
                  icon: Icons.file_download_outlined,
                  onPressed: () => _handleTakePhoto(context, wonderData.title),
                  semanticLabel: 'take photo',
                  size: 64,
                ),
              ],
            ),
          ),
        ),
        BottomCenter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /* TODO: Figure out Night Mode
              Switch(
                value: _isNightOn,
                onChanged: _handleNightToggle,
              ),
              Gap(context.insets.md),
              */
              SimpleCheckbox(active: _isTextOn, label: 'Show Title', onToggled: _handleTextToggle),
              Gap(context.insets.xl),
            ],
          ),
        ),
      ]),
    );
  }
}
