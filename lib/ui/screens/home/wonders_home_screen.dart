import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/controls/diagonal_page_indicator.dart';
import 'package:wonders/ui/common/gradient_container.dart';
import 'package:wonders/ui/common/themed_text.dart';
import 'package:wonders/ui/wonder_illustrations/common/animated_clouds.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_title_text.dart';

part '_vertical_swipe_controller.dart';
part 'widgets/_animated_arrow_button.dart';
part 'widgets/_text_content.dart';

class WondersHomeScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  WondersHomeScreen({Key? key}) : super(key: key);

  @override
  State<WondersHomeScreen> createState() => _WondersHomeScreenState();
}

/// Shows a horizontally scrollable list PageView sandwiched between Foreground and Background layers
/// arranged in a parallax style.
class _WondersHomeScreenState extends State<WondersHomeScreen> with SingleTickerProviderStateMixin {
  final _pageController = PageController(viewportFraction: 1);
  final _wonders = wondersLogic.all;
  late int _wonderIndex = _pageController.initialPage;

  late final _VerticalSwipeController _swipeController = _VerticalSwipeController(this, _showDetailsPage);

  bool _isSelected(WonderType t) => t == _wonders[_wonderIndex].type;

  void _handlePageViewChanged(v) => setState(() => _wonderIndex = v);

  void _handleSettingsPressed() => context.push(ScreenPaths.settings);

  void _showDetailsPage() => context.push(ScreenPaths.wonderDetails(_wonders[_wonderIndex].type));

  @override
  Widget build(BuildContext context) {
    final currentWonder = _wonders[_wonderIndex];
    return _swipeController.wrapGestureDetector(
      Stack(
        children: [
          /// Background
          ..._buildBgChildren(),

          /// Clouds
          FractionallySizedBox(
            widthFactor: 1,
            heightFactor: .5,
            child: AnimatedClouds(wonderType: currentWonder.type),
          ),

          /// Wonders Illustrations
          PageView(
            controller: _pageController,
            onPageChanged: _handlePageViewChanged,
            children: _buildMgChildren(),
          ),

          /// Foreground gradient-bottom, gets darker when swiping up
          BottomCenter(
            child: _buildSwipeableBgGradient(currentWonder.type.bgColor.withOpacity(.5)),
          ),

          /// Foreground decorators
          ..._buildFgChildren(),

          /// Foreground gradient-top, gets darker when swiping up
          BottomCenter(
            child: _buildSwipeableBgGradient(currentWonder.type.bgColor),
          ),

          /// Floating controls / UI
          AnimatedSwitcher(
            duration: context.times.fast,
            child: RepaintBoundary(
              // Lose state of child objects when index changes, this will re-run all the animated switcher and the arrow anim
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
                      child: _TextContent(wonderIndex: _wonderIndex, wonders: _wonders),
                    ),
                  ),
                  Gap(context.insets.sm),

                  Stack(
                    children: [
                      /// Expanding rounded rect that grows in height as user swipes up
                      Positioned.fill(
                        child: _buildSwipeableButtonBg(),
                      ),

                      /// Arrow Btn that fades in and out
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
          zoom: 1.3 + .4 * swipeAmt,
        );
        return IgnorePointer(child: WonderIllustration(e.type, config: config));
      });
    }).toList();
  }

  List<Widget> _buildMgChildren() {
    return _wonders.map((e) {
      return _swipeController.buildListener(builder: (swipeAmt, _, child) {
        final config = WonderIllustrationConfig.mg(
          isShowing: _isSelected(e.type),
          zoom: 1.3 + .05 * swipeAmt,
        );
        return WonderIllustration(e.type, config: config);
      });
    }).toList();
  }

  Widget _buildSwipeableButtonBg() {
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
        [context.colors.white.withOpacity(0), context.colors.white.withOpacity(1)],
        const [.3, 1],
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }

  Widget _buildSwipeableBgGradient(Color fgColor) {
    return _swipeController.buildListener(builder: (swipeAmt, isPointerDown, _) {
      return IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                fgColor.withOpacity(0),
                fgColor.withOpacity(fgColor.opacity * .75 + (isPointerDown ? .05 : 0) + swipeAmt * .20),
              ],
              stops: const [0, 1],
            ),
          ),
        ),
      );
    });
  }
}
