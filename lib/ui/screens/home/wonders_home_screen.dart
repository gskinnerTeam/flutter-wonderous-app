import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/wonders_logic.dart';
import 'package:wonders/ui/common/controls/diagonal_page_indicator.dart';
import 'package:wonders/ui/common/gradient_container.dart';
import 'package:wonders/ui/common/themed_text.dart';
import 'package:wonders/ui/screens/home/animated_clouds.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration.dart';

part 'animated_arrow_button.dart';

/// PageView sandwiched between Foreground and Background layers
/// arranged in a parallax style
class _WondersHomeScreenState extends State<WondersHomeScreen> with GetItStateMixin, SingleTickerProviderStateMixin {
  final _pageController = PageController(viewportFraction: 1);
  late int _wonderIndex = _pageController.initialPage;
  late final _SwipeController swipeController = _SwipeController(this, _showDetailsPage);

  void _handlePageViewChanged(v) => setState(() => _wonderIndex = v);

  void _handleSettingsPressed() => context.push(ScreenPaths.settings);

  void _showDetailsPage() => context.push(ScreenPaths.wonderDetails(wondersLogic.all.value[_wonderIndex].type));

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
      return ValueListenableBuilder(
          valueListenable: swipeController.swipeUpAmt,
          builder: (_, value, child) {
            final config = WonderIllustrationConfig.mg(
              isShowing: isSelected(e.type),
              zoom: 1.3 + .05 * swipeController.swipeUpAmt.value,
            );
            return WonderIllustration(e.type, config: config);
          });
    }).toList();

    List<Widget> fgChildren = wonders.map((e) {
      return ValueListenableBuilder(
          valueListenable: swipeController.swipeUpAmt,
          builder: (_, value, child) {
            final config = WonderIllustrationConfig.fg(
              isShowing: isSelected(e.type),
              zoom: 1.3 + .4 * swipeController.swipeUpAmt.value,
            );
            return WonderIllustration(e.type, config: config);
          });
    }).toList();

    return GestureDetector(
      onTapDown: (_) => swipeController.handleTapDown(),
      onTapUp: (_) => swipeController.handleTapCancelled(),
      onVerticalDragUpdate: swipeController.handleVerticalSwipeUpdate,
      onVerticalDragEnd: (_) => swipeController.handleVerticalSwipeCancelled(),
      onVerticalDragCancel: swipeController.handleVerticalSwipeCancelled,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          /// Sun / Clouds
          ...bgChildren,

          FractionallySizedBox(
            widthFactor: 1,
            heightFactor: .5,
            child: AnimatedClouds(wonderType: currentWonder.type),
          ),

          /// Wonders Illustrations
          PageView(
            controller: _pageController,
            children: mgChildren,
            physics: BouncingScrollPhysics(),
            onPageChanged: _handlePageViewChanged,
          ),

          /// Foreground decorators
          ...fgChildren.map((e) => IgnorePointer(child: e)),

          /// Foreground gradient, gets darker when swiping up
          BottomCenter(
            child: _SwipeableGradient(currentWonder.type.bgColor, swipeController: swipeController),
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

                  /// Settings Btn
                  AppTextBtn('Settings', onPressed: _handleSettingsPressed),
                  const Spacer(),

                  /// Title Content
                  IgnorePointer(
                    child: LightText(
                      child: _buildTitleAndPageIndicator(wonders, currentWonder),
                    ),
                  ),
                  Gap(context.insets.sm),

                  /// Arrow Btn w/ expanding background
                  Stack(
                    children: [
                      Positioned.fill(
                        child: _SwipeableButtonBg(swipeController: swipeController),
                      ),
                      _AnimatedArrowButton(onTap: _showDetailsPage),
                    ],
                  ),
                  Gap(context.insets.md),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildTitleAndPageIndicator(List<WonderData> wonders, WonderData currentWonder) {
    return Column(children: [
      /// Page indicator
      DiagonalPageIndicator(current: _wonderIndex + 1, total: wonders.length),
      Gap(context.insets.md),

      /// Title
      Hero(
        tag: '${currentWonder.type}-title',
        child: Text(
          currentWonder.titleWithBreaks.toUpperCase(),
          style: context.textStyles.h1.copyWith(height: 1),
          textAlign: TextAlign.center,
        ),
      ),
    ]);
  }
}

/// Holds various handlers for GestureDetector and tracks a vertical swipe gesture.
/// It translates the amount of swipe to a normalized [swipeUpAmt] value of 0-1, when 1 is reached it
/// dispatches a [onSwipeComplete] callback.
///
/// If a swipe is released early, an animation is run, resetting it back to 0.
class WondersHomeScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  WondersHomeScreen({Key? key}) : super(key: key);

  @override
  State<WondersHomeScreen> createState() => _WondersHomeScreenState();
}

class _SwipeController {
  _SwipeController(this.ticker, this.onSwipeComplete);
  final TickerProvider ticker;
  final swipeUpAmt = ValueNotifier<double>(0);
  final isPointerDown = ValueNotifier<bool>(false);
  late final swipeReleaseAnim = AnimationController(vsync: ticker)..addListener(handleSwipeReleaseAnimTick);
  final double _pullToViewDetailsThreshold = 100;
  final VoidCallback onSwipeComplete;

  /// When the _swipeReleaseAnim plays, sync its value to _swipeUpAmt
  void handleSwipeReleaseAnimTick() => swipeUpAmt.value = swipeReleaseAnim.value;
  void handleTapDown() => isPointerDown.value = true;
  void handleTapCancelled() => isPointerDown.value = false;

  void handleVerticalSwipeCancelled() {
    swipeReleaseAnim.duration = swipeUpAmt.value.seconds * .5;
    swipeReleaseAnim.reverse(from: swipeUpAmt.value);
    isPointerDown.value = false;
  }

  void handleVerticalSwipeUpdate(DragUpdateDetails details) {
    if (swipeReleaseAnim.isAnimating) swipeReleaseAnim.stop();
    if (details.delta.dy > 0) {
      swipeUpAmt.value = 0;
    } else {
      isPointerDown.value = true;
      double value = (swipeUpAmt.value - details.delta.dy / _pullToViewDetailsThreshold).clamp(0, 1);
      if (value != swipeUpAmt.value) {
        swipeUpAmt.value = value;
        if (swipeUpAmt.value == 1) {
          onSwipeComplete();
        }
      }
    }
    //print(_swipeUpAmt.value);
  }
}

/// A rounded container that scales outside of it's parent bounds. Lives underneath the arrow button
/// and is tied into the [swipeUpAmt] value, increasing in size and opacity as the value approaches 1.
class _SwipeableButtonBg extends StatelessWidget {
  const _SwipeableButtonBg({Key? key, required this.swipeController}) : super(key: key);

  final _SwipeController swipeController;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: swipeController.swipeUpAmt,
      builder: (_, amount, child) {
        double heightFactor = .5 + .5 * (1 + swipeController.swipeUpAmt.value * 4);
        return FractionallySizedBox(
          alignment: Alignment.bottomCenter,
          heightFactor: heightFactor,
          child: Opacity(opacity: amount * .5, child: child),
        );
      },
      child: VtGradient(
        [context.colors.white.withOpacity(0), context.colors.white.withOpacity(1)],
        const [.3, 1],
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }
}

/// A simple gradient with adjustable opacity,
class _SwipeableGradient extends StatelessWidget {
  const _SwipeableGradient(this.fgColor, {Key? key, required this.swipeController}) : super(key: key);
  final Color fgColor;
  final _SwipeController swipeController;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: swipeController.swipeUpAmt,
      builder: (_, swipeAmt, __) => ValueListenableBuilder<bool>(
        valueListenable: swipeController.isPointerDown,
        builder: (_, isPointerDown, __) {
          return IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    fgColor.withOpacity(0),
                    fgColor.withOpacity(.5 + (isPointerDown ? .1 : 0) + swipeAmt * .4),
                  ],
                  stops: const [0, 1],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
