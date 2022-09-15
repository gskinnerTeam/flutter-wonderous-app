import 'dart:async';

import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/app_icons.dart';
import 'package:wonders/ui/common/blend_mask.dart';
import 'package:wonders/ui/common/compass_divider.dart';
import 'package:wonders/ui/common/curved_clippers.dart';
import 'package:wonders/ui/common/google_maps_marker.dart';
import 'package:wonders/ui/common/gradient_container.dart';
import 'package:wonders/ui/common/hidden_collectible.dart';
import 'package:wonders/ui/common/scaling_list_item.dart';
import 'package:wonders/ui/common/static_text_scale.dart';
import 'package:wonders/ui/common/themed_text.dart';
import 'package:wonders/ui/common/utils/context_utils.dart';
import 'package:wonders/ui/wonder_illustrations/common/animated_clouds.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_title_text.dart';

part 'widgets/_app_bar.dart';
part 'widgets/_callout.dart';
part 'widgets/_circular_title_bar.dart';
part 'widgets/_collapsing_pull_quote_image.dart';
part 'widgets/_large_simple_quote.dart';
part 'widgets/_scrolling_content.dart';
part 'widgets/_section_divider.dart';
part 'widgets/_sliding_image_stack.dart';
part 'widgets/_title_text.dart';
part 'widgets/_top_illustration.dart';

class WonderEditorialScreen extends StatefulWidget {
  const WonderEditorialScreen(this.data, {Key? key, required this.onScroll})
      : super(key: key);
  final WonderData data;
  final void Function(double scrollPos) onScroll;

  @override
  State<WonderEditorialScreen> createState() => _WonderEditorialScreenState();
}

class _WonderEditorialScreenState extends State<WonderEditorialScreen> {
  late final ScrollController _scroller = ScrollController()
    ..addListener(_handleScrollChanged);
  final _scrollPos = ValueNotifier(0.0);
  final _sectionIndex = ValueNotifier(0);
  final _scrollToPopThreshold = 50;
  bool _isPointerDown = false;

  /// The largest scroll position at which we should show the colored background
  /// widget.
  static const _includeBackgroundThreshold = 1000;

  /// Whether the colored background widget should be included in this view.
  ///
  /// This value should be true for scroll positions ranging from 0 to 1000, and
  /// should be false for all values larger.
  final _includeBackground = ValueNotifier<bool>(true);

  /// The largest scroll position at which we should show the top illustration.
  static const _includeTopIllustrationThreshold = 700;

  /// The opacity value for the top illustration.
  ///
  /// This value should be clamped to (0, 1) and will shrink to 0 as the scroll
  /// position increases to [_includeTopIllustrationThreshold].
  final _topIllustrationOpacity = ValueNotifier<double>(1.0);

  /// The largest scroll position at which we should show the text content.
  static const _includeTextThreshold = 500.0;

  /// The scroll position notifier that the text display widget below should
  /// listen to.
  ///
  /// This value should be clamped to (0, [_includeTextThreshold]). This scroll
  /// position value determines the opacity of the text, which decreases to 0.0
  /// as the scroll position increases to [_includeTextThreshold].
  final _scrollPositionForTextContent = ValueNotifier(0.0);

  @override
  void dispose() {
    _scroller.dispose();
    super.dispose();
  }

  /// Various [ValueListenableBuilders] are mapped to the _scrollPos and will rebuild when it changes
  void _handleScrollChanged() {
    _scrollPos.value = _scroller.position.pixels;
    widget.onScroll.call(_scrollPos.value);

    _includeBackground.value = _scrollPos.value <= _includeBackgroundThreshold;

    // Opacity value between 0 and 1, based on the amt scrolled. Once
    // [_topIllustrationOpacity.value] reaches its clamped ends (0 or 1), it
    // will not notify on subsequent assigments to the same value, which
    // prevents us from triggering an unnecessary rebuild on Widgets that are
    // listening to this notifier.
    _topIllustrationOpacity.value = (1 - _scrollPos.value / _includeTopIllustrationThreshold).clamp(0, 1);

    // We clamp to [_includeTextThreshold] so that we do not trigger unnecessary
    // rebuilds on Widgets that are listening to this notifier. At a scroll
    // position of [_includeTextThreshold] and beyond, we would be rendering the
    // text with an opacity value of 0.0, and there is no point in doing any
    // building or rendering for a transparent item.
    _scrollPositionForTextContent.value = _scrollPos.value.clamp(0, _includeTextThreshold);

    // If user pulls far down on the elastic list, pop back to
    if (_scrollPos.value < -_scrollToPopThreshold) {
      if (_isPointerDown) {
        context.pop();
        _scroller.removeListener(_handleScrollChanged);
      }
    }
  }

  bool _checkPointerIsDown(d) => _isPointerDown = d.dragDetails != null;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      bool shortMode = constraints.biggest.height < 700;
      double illustrationHeight = shortMode ? 250 : 280;
      double minAppBarHeight = shortMode ? 80 : 120;
      double maxAppBarHeight = shortMode ? 400 : 500;

      return NotificationListener<ScrollUpdateNotification>(
        onNotification: _checkPointerIsDown,
        child: ColoredBox(
          color: $styles.colors.offWhite,
          child: Stack(
            children: [
              /// Background
              ValueListenableBuilder<bool>(
                valueListenable: _includeBackground,
                builder: (context, include, child) => include ? child! : const SizedBox(),
                child: Positioned.fill(
                  child: Container(
                    color: widget.data.type.bgColor,
                  ),
                ),
              ),

              /// Top Illustration - Sits underneath the scrolling content, fades out as it scrolls
              SizedBox(
                height: illustrationHeight,
                child: ValueListenableBuilder<double>(
                  valueListenable: _topIllustrationOpacity,
                  builder: (_, opacity, child) {
                    if (opacity == 0) {
                      // No point in rendering something that is transparent.
                      return SizedBox();
                    }
                    return Opacity(opacity: opacity, child: child);
                  },
                  // This is due to a bug: https://github.com/flutter/flutter/issues/101872
                  child: RepaintBoundary(
                      child: _TopIllustration(widget.data.type)),
                ),
              ),

              /// Scrolling content - Includes an invisible gap at the top, and then scrolls over the illustration
              CustomScrollView(
                primary: false,
                controller: _scroller,
                cacheExtent: 500,
                slivers: [
                  /// Invisible padding at the top of the list, so the illustration shows through the btm
                  SliverToBoxAdapter(
                    child: SizedBox(height: illustrationHeight),
                  ),

                  /// Text content, animates itself to hide behind the app bar as it scrolls up
                  SliverToBoxAdapter(
                    child: ValueListenableBuilder<double>(
                      valueListenable: _scrollPositionForTextContent,
                      builder: (_, value, child) {
                        double offsetAmt = max(0, value * .3);
                        double opacity = (1 - value / _includeTextThreshold).clamp(0, 1);
                        if (opacity == 0) {
                          // No point in rendering something that is transparent.
                          return SizedBox();
                        }
                        return Transform.translate(
                          offset: Offset(0, offsetAmt),
                          child: Opacity(opacity: opacity, child: child),
                        );
                      },
                      child: _TitleText(widget.data, scroller: _scroller),
                    ),
                  ),

                  /// Collapsing App bar, pins to the top of the list
                  SliverAppBar(
                    pinned: true,
                    collapsedHeight: minAppBarHeight,
                    toolbarHeight: minAppBarHeight,
                    expandedHeight: maxAppBarHeight,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: SizedBox.shrink(),
                    flexibleSpace: SizedBox.expand(
                      child: _AppBar(
                        widget.data.type,
                        scrollPos: _scrollPos,
                        sectionIndex: _sectionIndex,
                      ).animate().fade(
                          duration: $styles.times.med,
                          delay: $styles.times.pageTransition),
                    ),
                  ),

                  /// Editorial content (text and images)
                  _ScrollingContent(widget.data,
                      scrollPos: _scrollPos, sectionNotifier: _sectionIndex),

                  /// Bottom padding
                  SliverToBoxAdapter(
                    child:
                        Container(height: 150, color: $styles.colors.offWhite),
                  ),
                ],
              ),

              /// Home Btn
              AnimatedBuilder(
                  animation: _scroller,
                  builder: (_, child) {
                    return AnimatedOpacity(
                      opacity: _scrollPos.value > 0 ? 0 : 1,
                      duration: $styles.times.med,
                      child: child,
                    );
                  },
                  child: BackBtn(icon: AppIcons.north).safe()),
            ],
          ),
        ),
      );
    });
  }
}
