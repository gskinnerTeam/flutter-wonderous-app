import 'package:flutter/rendering.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/app_icons.dart';
import 'package:wonders/ui/common/controls/app_page_indicator.dart';
import 'package:wonders/ui/common/controls/diagonal_text_page_indicator.dart';
import 'package:wonders/ui/common/gradient_container.dart';
import 'package:wonders/ui/common/themed_text.dart';
import 'package:wonders/ui/common/utils/app_haptics.dart';
import 'package:wonders/ui/screens/home_menu/home_menu.dart';
import 'package:wonders/ui/wonder_illustrations/common/animated_clouds.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_title_text.dart';

part '_vertical_swipe_controller.dart';
part 'widgets/_animated_arrow_button.dart';

class HomeScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// Shows a horizontally scrollable list PageView sandwiched between Foreground and Background layers
/// arranged in a parallax style.
class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final _pageController = PageController(
    viewportFraction: 1,
    initialPage: _numWonders * 9999, // allow 'infinite' scrolling by starting at a very high page
  );
  final _wonders = wondersLogic.all;
  bool _isMenuOpen = false;

  /// Set initial wonderIndex
  late int _wonderIndex = 0;
  int get _numWonders => _wonders.length;

  /// Used to polish the transition when leaving this page for the details view.
  /// Used to capture the _swipeAmt at the time of transition, and freeze the wonder foreground in place as we transition away.
  double? _swipeOverride;

  /// Used to let the foreground fade in when this view is returned to (from details)
  bool _fadeInOnNextBuild = false;

  /// All of the items that should fade in when returning from details view.
  /// Using individual tweens is more efficient than tween the entire parent
  final _fadeAnims = <AnimationController>[];

  WonderData get currentWonder => _wonders[_wonderIndex];

  late final _VerticalSwipeController _swipeController = _VerticalSwipeController(this, _showDetailsPage);

  bool _isSelected(WonderType t) => t == currentWonder.type;

  void _handlePageViewChanged(v) {
    setState(() => _wonderIndex = v % _numWonders);
    AppHaptics.lightImpact();
  }

  void _handleOpenMenuPressed() async {
    setState(() => _isMenuOpen = true);
    WonderType? pickedWonder = await appLogic.showFullscreenDialogRoute<WonderType>(
      context,
      HomeMenu(data: currentWonder),
    );
    setState(() => _isMenuOpen = false);
    if (pickedWonder != null) {
      _setPageIndex(_wonders.indexWhere((w) => w.type == pickedWonder));
    }
  }

  void _handleFadeAnimInit(AnimationController controller) {
    _fadeAnims.add(controller);
    controller.value = 1;
  }

  void _handlePageIndicatorDotPressed(int index) => _setPageIndex(index);

  void _setPageIndex(int index) {
    if (index == _wonderIndex) return;
    // To support infinite scrolling, we can't jump directly to the pressed index. Instead, make it relative to our current position.
    final pos = ((_pageController.page ?? 0) / _numWonders).floor() * _numWonders;
    _pageController.jumpToPage(pos + index);
  }

  void _showDetailsPage() async {
    _swipeOverride = _swipeController.swipeAmt.value;
    context.push(ScreenPaths.wonderDetails(currentWonder.type));
    await Future.delayed(100.ms);
    _swipeOverride = null;
    _fadeInOnNextBuild = true;
  }

  void _startDelayedFgFade() async {
    for (var a in _fadeAnims) {
      a.value = 0;
    }
    await Future.delayed(300.ms);
    for (var a in _fadeAnims) {
      a.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_fadeInOnNextBuild == true) {
      _startDelayedFgFade();
      _fadeInOnNextBuild = false;
    }
    return _swipeController.wrapGestureDetector(
      Container(
        color: $styles.colors.black,
        child: Stack(
          children: [
            /// Background
            ..._buildBgChildren(),

            /// Clouds
            FractionallySizedBox(
              widthFactor: 1,
              heightFactor: .5,
              child: AnimatedClouds(wonderType: currentWonder.type, opacity: 1),
            ),

            /// Wonders Illustrations
            MergeSemantics(
              child: Semantics(
                header: true,
                image: true,
                liveRegion: true,
                onIncrease: () => _setPageIndex(_wonderIndex + 1),
                onDecrease: () => _setPageIndex(_wonderIndex - 1),
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _handlePageViewChanged,
                  itemBuilder: _buildMgChild,
                ),
              ),
            ),

            Stack(children: [
              /// Foreground gradient-1, gets darker when swiping up
              BottomCenter(
                child: _buildSwipeableBgGradient(currentWonder.type.bgColor.withOpacity(.65)),
              ),

              /// Foreground decorators
              ..._buildFgChildren(),

              /// Foreground gradient-2, gets darker when swiping up
              BottomCenter(
                child: _buildSwipeableBgGradient(currentWonder.type.bgColor.withOpacity(1)),
              ),

              /// Floating controls / UI
              AnimatedSwitcher(
                duration: $styles.times.fast,
                child: RepaintBoundary(
                  key: ObjectKey(currentWonder),
                  child: IgnorePointer(
                    ignoringSemantics: false,
                    child: OverflowBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: double.infinity),
                          const Spacer(),

                          /// Title Content
                          LightText(
                            child: MergeSemantics(
                              child: Transform.translate(
                                offset: Offset(0, 30),
                                child: Column(
                                  children: [
                                    WonderTitleText(currentWonder, enableShadows: true),

                                    //Gap($styles.insets.sm),
                                    AppPageIndicator(
                                      count: _numWonders,
                                      controller: _pageController,
                                      color: $styles.colors.white,
                                      dotSize: 8,
                                      onDotPressed: _handlePageIndicatorDotPressed,
                                      semanticPageTitle: $strings.homeSemanticWonder,
                                    ),

                                    /// Page indicator
                                    // IgnorePointer(
                                    //   child: DiagonalTextPageIndicator(current: _wonderIndex + 1, total: _numWonders),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //Gap($styles.insets.xs),

                          /// Animated arrow and background
                          /// Wrap in a container that is full-width to make it easier to find for screen readers
                          MergeSemantics(
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,

                              /// Lose state of child objects when index changes, this will re-run all the animated switcher and the arrow anim
                              key: ValueKey(_wonderIndex),
                              child: Stack(
                                children: [
                                  /// Expanding rounded rect that grows in height as user swipes up
                                  Positioned.fill(
                                    child: _buildSwipeableArrowBg(),
                                  ),

                                  /// Arrow Btn that fades in and out
                                  _AnimatedArrowButton(onTap: _showDetailsPage, semanticTitle: currentWonder.title),
                                ],
                              ),
                            ),
                          ),
                          Gap($styles.insets.md),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// Menu Btn
              TopLeft(
                child: AnimatedOpacity(
                  duration: $styles.times.fast,
                  opacity: _isMenuOpen ? 0 : 1,
                  child: MergeSemantics(
                    child: Semantics(
                      sortKey: OrdinalSortKey(0),
                      child: CircleIconBtn(
                        icon: AppIcons.menu,
                        onPressed: _handleOpenMenuPressed,
                        semanticLabel: $strings.homeSemanticOpenMain,
                      ).safe(),
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ).animate().fadeIn(),
      ),
    );
  }

  Widget _buildMgChild(_, index) {
    final wonder = _wonders[index % _wonders.length];
    final wonderType = wonder.type;
    bool isShowing = _isSelected(wonderType);
    return _swipeController.buildListener(builder: (swipeAmt, _, child) {
      final config = WonderIllustrationConfig.mg(
        isShowing: isShowing,
        zoom: .05 * swipeAmt,
      );
      return ExcludeSemantics(
        excluding: !isShowing,
        child: Semantics(
          label: wonder.title,
          child: WonderIllustration(wonderType, config: config),
        ),
      );
    });
  }

  List<Widget> _buildBgChildren() {
    return _wonders.map((e) {
      final config = WonderIllustrationConfig.bg(isShowing: _isSelected(e.type));
      return WonderIllustration(e.type, config: config);
    }).toList();
  }

  List<Widget> _buildFgChildren() {
    return _wonders.map((e) {
      return _swipeController.buildListener(builder: (swipeAmt, _, child) {
        final config = WonderIllustrationConfig.fg(
          isShowing: _isSelected(e.type),
          zoom: .4 * (_swipeOverride ?? swipeAmt),
        );
        return Animate(
            effects: const [FadeEffect()],
            onPlay: _handleFadeAnimInit,
            child: IgnorePointer(child: WonderIllustration(e.type, config: config)));
      });
    }).toList();
  }

  Widget _buildSwipeableArrowBg() {
    return _swipeController.buildListener(
      builder: (swipeAmt, _, child) {
        double heightFactor = .5 + .5 * (1 + swipeAmt * 4);
        return FractionallySizedBox(
          alignment: Alignment.bottomCenter,
          heightFactor: heightFactor,
          child: Opacity(opacity: swipeAmt * .5, child: child),
        );
      },
      child: VtGradient(
        [$styles.colors.white.withOpacity(0), $styles.colors.white.withOpacity(1)],
        const [.3, 1],
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }

  Widget _buildSwipeableBgGradient(Color fgColor) {
    return _swipeController.buildListener(builder: (swipeAmt, isPointerDown, _) {
      return IgnorePointer(
        child: FractionallySizedBox(
          heightFactor: .6,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  fgColor.withOpacity(0),
                  fgColor.withOpacity(.5 + fgColor.opacity * .25 + (isPointerDown ? .05 : 0) + swipeAmt * .20),
                ],
                stops: const [0, 1],
              ),
            ),
          ),
        ),
      );
    });
  }
}
