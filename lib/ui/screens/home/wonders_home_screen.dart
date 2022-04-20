import 'dart:async';

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/controls/diagonal_page_indicator.dart';
import 'package:wonders/ui/common/gradient_container.dart';
import 'package:wonders/ui/common/themed_text.dart';
import 'package:wonders/ui/wonder_illustrations/common/animated_clouds.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration.dart';

part 'widgets/animated_arrow_button.dart';
part 'widgets/vertical_swipe_controller.dart';
part 'widgets/swipeable_gradient.dart';
part 'widgets/expanding_button_bg.dart';
part 'widgets/text_content.dart';

class WondersHomeScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  WondersHomeScreen({Key? key}) : super(key: key);

  @override
  State<WondersHomeScreen> createState() => _WondersHomeScreenState();
}

/// Shows a horizontally scrollable list PageView sandwiched between Foreground and Background layers
/// arranged in a parallax style.
class _WondersHomeScreenState extends State<WondersHomeScreen> with SingleTickerProviderStateMixin {
  final _pageController = PageController(viewportFraction: 1);
  final wonders = wondersLogic.enabled;
  late int _wonderIndex = _pageController.initialPage;

  late final _VerticalSwipeController swipeController = _VerticalSwipeController(this, _showDetailsPage);

  bool isSelected(WonderType t) => t == wonders[_wonderIndex].type;

  void _handlePageViewChanged(v) => setState(() => _wonderIndex = v);

  void _handleSettingsPressed() => context.push(ScreenPaths.settings);

  void _showDetailsPage() => context.push(ScreenPaths.wonderDetails(wondersLogic.enabled[_wonderIndex].type));

  @override
  Widget build(BuildContext context) {
    final currentWonder = wonders[_wonderIndex];

    /// Build children for the various parallax layers
    List<Widget> bgChildren = _buildBgChildren();
    List<Widget> mgChildren = _buildMgChildren();
    List<Widget> fgChildren = _buildFgChildren();

    return swipeController.wrapGestureDetector(
      Stack(
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
            onPageChanged: _handlePageViewChanged,
          ),

          /// Foreground gradient-bottom, gets darker when swiping up
          BottomCenter(
            child: _SwipeableGradient(currentWonder.type.bgColor, swipeController: swipeController),
          ),

          /// Foreground decorators
          ...fgChildren.map((e) => IgnorePointer(child: e)),

          /// Foreground gradient-top, gets darker when swiping up
          BottomCenter(
            child: _SwipeableGradient(currentWonder.type.bgColor.withOpacity(.2), swipeController: swipeController),
          ),

          /// Floatiang controls / UI
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
                      child: _TextContent(wonderIndex: _wonderIndex, wonders: wonders),
                    ),
                  ),
                  Gap(context.insets.sm),

                  Stack(
                    children: [
                      /// Expanding rounded rect that grows in height as user swipes up
                      Positioned.fill(
                        child: _ExpandingButtonBg(swipeController: swipeController),
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

  List<ValueListenableBuilder<double>> _buildFgChildren() {
    return wonders.map((e) {
      return ValueListenableBuilder(
          valueListenable: swipeController.swipeAmt,
          builder: (_, value, child) {
            final config = WonderIllustrationConfig.fg(
              isShowing: isSelected(e.type),
              zoom: 1.3 + .4 * swipeController.swipeAmt.value,
            );
            return WonderIllustration(e.type, config: config);
          });
    }).toList();
  }

  List<WonderIllustration> _buildBgChildren() {
    return wonders.map((e) {
      final config = WonderIllustrationConfig.bg(isShowing: isSelected(e.type));
      return WonderIllustration(e.type, config: config);
    }).toList();
  }

  List<ValueListenableBuilder<double>> _buildMgChildren() {
    return wonders.map((e) {
      return ValueListenableBuilder(
          valueListenable: swipeController.swipeAmt,
          builder: (_, value, child) {
            final config = WonderIllustrationConfig.mg(
              isShowing: isSelected(e.type),
              zoom: 1.3 + .05 * swipeController.swipeAmt.value,
            );
            return WonderIllustration(e.type, config: config);
          });
    }).toList();
  }
}
