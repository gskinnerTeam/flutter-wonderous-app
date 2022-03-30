import 'package:screenshot/screenshot.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/blend_mask.dart';
import 'package:wonders/ui/common/buttons.dart';
import 'package:wonders/ui/common/diagonal_page_indicator.dart';
import 'package:wonders/ui/common/eight_way_swipe_detector.dart';
import 'package:wonders/ui/screens/home/animated_clouds.dart';
import 'package:wonders/ui/screens/home/wonder_layers/chichen_itza_layer.dart';
import 'package:wonders/ui/screens/home/wonder_layers/taj_mahal_layer.dart';

/// PageView sandwiched between Foreground and Background layers
/// arranged in a parallax style
class WondersHomeScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  WondersHomeScreen({Key? key}) : super(key: key);

  @override
  State<WondersHomeScreen> createState() => _WondersHomeScreenState();
}

class _WondersHomeScreenState extends State<WondersHomeScreen> with GetItStateMixin {
  final _pageController = PageController(viewportFraction: 1);
  final _screenshots = ScreenshotController();
  late int _wonderIndex = _pageController.initialPage;

  /// Create an array of all the parallax layers
  final List<WonderHomeLayersConfig> _wonderLayerSets = [
    chichenItzaHomeLayers,
    tajMahalHomeLayers,
  ];

  void _handlePageViewChanged(v) => setState(() => _wonderIndex = v);

  void _handleSwipe(Offset dir) {
    if (dir.dy == -1 && dir.dx == 0) _showDetailsPage();
  }

  void _showDetailsPage() => context.push(ScreenPaths.wonderDetails(wonders.all.value[_wonderIndex].type));

  void _handleSaveWallPaperPressed() async =>
      app.saveWallpaper(context, _wonderLayerSets[_wonderIndex].mg, name: 'wonder$_wonderIndex');

  void _handleSettingsPressed() => context.push(ScreenPaths.settings);

  @override
  Widget build(BuildContext context) {
    /// Collect children for the various layers
    final mgChildren = _wonderLayerSets.map((e) => e.mg).toList();
    final fgChildren = _wonderLayerSets.map((e) {
      bool isShowing = _wonderLayerSets.indexOf(e) == _wonderIndex;
      return e.fgBuilder(isShowing);
    }).toList();

    /// Layer children in a stack with bg on bottom and bg on top
    return EightWaySwipeDetector(
      onSwipe: _handleSwipe,
      child: Stack(children: [
        /// Bg
        Positioned.fill(
          child: AnimatedSwitcher(
            duration: context.style.times.fast,
            child: _wonderLayerSets[_wonderIndex].bg,
          ),
        ),

        /// Clouds fly in, and then fly out...
        /// Each wonder can have it's own showable cloud layer?
        AnimatedCloudStack(),

        /// Mg
        Screenshot(
          controller: _screenshots,
          child: PageView(
            controller: _pageController,
            children: mgChildren.map((e) {
              return AnimatedOpacity(
                opacity: mgChildren.indexOf(e) == _wonderIndex ? 1 : 0,
                duration: context.times.fast,
                child: e,
              );
            }).toList(),
            physics: BouncingScrollPhysics(),
            onPageChanged: _handlePageViewChanged,
          ),
        ),

        /// Fg
        IgnorePointer(
            child: Stack(children: [
          /// Each wonder has it's own foreground, that animates in and out
          ...fgChildren,

          /// Bottom Gradient, animates when color changes
          BottomCenter(
            child: _AnimatedGradient(_wonderLayerSets[_wonderIndex].fgColor),
          )
        ])),

        /// Floating controls / UI
        AnimatedSwitcher(
          duration: context.style.times.fast,
          child: Column(
            key: ValueKey(_wonderIndex),
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: double.infinity),
              Gap(context.insets.lg * 3),

              /// Save Background Btn
              AppBtn(child: Text('Save Background'), onPressed: _handleSaveWallPaperPressed),
              AppBtn(child: Text('Settings'), onPressed: _handleSettingsPressed),
              Spacer(),

              IgnorePointer(
                child: Column(children: [
                  /// Page indicator
                  DiagonalPageIndicator(current: _wonderIndex + 1, total: _wonderLayerSets.length),
                  Gap(context.insets.md),

                  /// Title
                  SizedBox(
                    width: 350,
                    child: Text(
                      _wonderLayerSets[_wonderIndex].data.title.toUpperCase(),
                      style: context.style.text.titleFont.copyWith(fontSize: 64, height: 1),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
              ),

              /// Down arrow
              AppBtn(child: Icon(Icons.arrow_downward, size: 64), onPressed: _showDetailsPage),
              Gap(context.style.insets.md),
            ],
          ),
        )
      ]),
    );
  }
}

class _AnimatedGradient extends StatelessWidget {
  _AnimatedGradient(this.fgColor, {Key? key}) : super(key: key);
  final Color fgColor;
  late final _gradientDec = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [fgColor.withOpacity(0), fgColor.withOpacity(.75)],
          stops: const [0, 1]));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.heightPx * .6,
      child: AnimatedContainer(
        duration: context.times.med,
        decoration: _gradientDec,
      ),
    );
  }
}

/// Represents a set of layers for a single wonder
class WonderHomeLayersConfig {
  WonderHomeLayersConfig(this.data,
      {required this.bg, required this.mg, required this.fgBuilder, required this.fgColor});
  WonderData data;
  final Color fgColor;
  final Widget bg;
  final Widget mg;
  final Widget Function(bool isShowing) fgBuilder;
}

/// A shared API for widgets that have an `isShowing` field
abstract class ShowableLayer extends StatelessWidget {
  const ShowableLayer({Key? key, required this.isShowing}) : super(key: key);
  final bool isShowing;
}
