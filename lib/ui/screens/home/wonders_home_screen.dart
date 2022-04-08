import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/wonders_logic.dart';
import 'package:wonders/ui/common/controls/buttons.dart';
import 'package:wonders/ui/common/controls/diagonal_page_indicator.dart';
import 'package:wonders/ui/common/themed_text.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration.dart';

/// PageView sandwiched between Foreground and Background layers
/// arranged in a parallax style
class WondersHomeScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  WondersHomeScreen({Key? key}) : super(key: key);

  @override
  State<WondersHomeScreen> createState() => _WondersHomeScreenState();
}

class _WondersHomeScreenState extends State<WondersHomeScreen> with GetItStateMixin, SingleTickerProviderStateMixin {
  final double _pullToViewDetailsThreshold = 100;
  final _pageController = PageController(viewportFraction: 1);
  late int _wonderIndex = _pageController.initialPage;
  final _swipeUpAmt = ValueNotifier<double>(0);
  late final _swipeReleaseAnim = AnimationController(vsync: this)..addListener(_handleSwipeReleaseAnimTick);

  void _handlePageViewChanged(v) => setState(() => _wonderIndex = v);

  void _showDetailsPage() => context.push(ScreenPaths.wonderDetails(wondersLogic.all.value[_wonderIndex].type));

  // TODO: FIX, add screen shot button, that uses off-screen widget to render
  // void _handleSaveWallPaperPressed() async {
  //   //  app.saveWallpaper(context, _wonderLayerSets[_wonderIndex].mg, name: 'wonder$_wonderIndex');
  // }

  /// When the _swipeReleaseAnim plays, sync its value to _swipeUpAmt
  void _handleSwipeReleaseAnimTick() => _swipeUpAmt.value = _swipeReleaseAnim.value;

  void _handleSettingsPressed() => context.push(ScreenPaths.settings);
  void _handleVerticalSwipeCancelled() {
    _swipeReleaseAnim.duration = _swipeUpAmt.value.seconds;
    _swipeReleaseAnim.reverse(from: _swipeUpAmt.value);
  }

  void _handleVerticalSwipeUpdate(DragUpdateDetails details) {
    if (_swipeReleaseAnim.isAnimating) _swipeReleaseAnim.stop();
    if (details.delta.dy > 0) {
      _swipeUpAmt.value = 0;
    } else {
      double value = (_swipeUpAmt.value - details.delta.dy / _pullToViewDetailsThreshold).clamp(0, 1);
      if (value != _swipeUpAmt.value) {
        _swipeUpAmt.value = value;
        if (_swipeUpAmt.value == 1) {
          _showDetailsPage();
        }
      }
    }
    //print(_swipeUpAmt.value);
  }

  @override
  Widget build(BuildContext context) {
    final wonders = watchX((WondersLogic w) => w.all);
    final currentWonder = wonders[_wonderIndex];
    bool isSelected(WonderType t) => t == wonders[_wonderIndex].type;

    /// Collect children for the various layers
    List<Widget> bgChildren = wonders.map((e) {
      final config = WonderIllustrationConfig.bg(isShowing: isSelected(e.type));
      return WonderIllustration(e.type, config: config);
    }).toList();

    List<Widget> mgChildren = wonders.map((e) {
      final config = WonderIllustrationConfig.mg(isShowing: isSelected(e.type));
      return WonderIllustration(e.type, config: config);
    }).toList();

    List<Widget> fgChildren = wonders.map((e) {
      final config = WonderIllustrationConfig.fg(isShowing: isSelected(e.type));
      return WonderIllustration(e.type, config: config);
    }).toList();

    return GestureDetector(
      onVerticalDragUpdate: _handleVerticalSwipeUpdate,
      onVerticalDragEnd: (_) => _handleVerticalSwipeCancelled(),
      onVerticalDragCancel: _handleVerticalSwipeCancelled,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          /// Sun / Clouds
          ...bgChildren,

          /// Wonder
          PageView(
            controller: _pageController,
            children: mgChildren,
            physics: BouncingScrollPhysics(),
            onPageChanged: _handlePageViewChanged,
          ),

          /// Foreground decorators
          ...fgChildren.map((e) => IgnorePointer(child: e)),

          /// Foreground gradient
          BottomCenter(
            // TODO: Gradient should get darker when pulling up...
            child: ValueListenableBuilder<double>(
              valueListenable: _swipeUpAmt,
              builder: (_, value, __) => _BottomGradient(
                currentWonder.type.bgColor,
                onSwipeOrPress: _showDetailsPage,
                opacity: .3 + value * .7,
              ),
            ),
          ),

          /// Floating controls / UI
          AnimatedSwitcher(
            duration: context.times.fast,
            child: RepaintBoundary(
              key: ValueKey(_wonderIndex),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: double.infinity),
                  Gap(context.insets.lg * 3),

                  /// Save Background Btn
                  // AppBtn(child: Text('Save Background'), onPressed: _handleSaveWallPaperPressed),
                  AppBtn(child: const Text('Settings'), onPressed: _handleSettingsPressed),
                  const Spacer(),

                  IgnorePointer(
                    child: LightText(
                      child: Column(children: [
                        /// Page indicator
                        DiagonalPageIndicator(current: _wonderIndex + 1, total: wonders.length),
                        Gap(context.insets.md),

                        /// Title
                        Text(
                          currentWonder.titleWithBreaks.toUpperCase(),
                          style: context.textStyles.h1.copyWith(height: 1),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                    ),
                  ),
                  _AnimatedArrow(onTap: _showDetailsPage),
                  Gap(context.insets.md),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomGradient extends StatelessWidget {
  _BottomGradient(this.fgColor, {Key? key, required this.onSwipeOrPress, required this.opacity}) : super(key: key);
  final Color fgColor;
  final double opacity;
  final VoidCallback onSwipeOrPress;

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [fgColor.withOpacity(0), fgColor.withOpacity(opacity.clamp(0, 1))],
                stops: const [0, 1]),
          ),
        ),
      );
}

class _AnimatedArrow extends StatelessWidget {
  const _AnimatedArrow({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: context.times.fast,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99),
          border: Border.all(color: context.colors.text),
        ),
        padding: EdgeInsets.symmetric(vertical: 28, horizontal: 6),
        child: GTweener(
          [GFade(), GMove(from: Offset(0, -10), to: Offset(0, 10))],
          duration: 2.seconds,
          onInit: (c) => c.animation.repeat(),
          child: Icon(Icons.arrow_downward, size: 24, color: context.colors.text),
        ),
      ),
    );
  }
}
