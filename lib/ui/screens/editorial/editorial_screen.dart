import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/blend_mask.dart';
import 'package:wonders/ui/common/context_utils.dart';
import 'package:wonders/ui/common/controls/eight_way_swipe_detector.dart';
import 'package:wonders/ui/common/curved_clippers.dart';
import 'package:wonders/ui/common/placeholder_image.dart';
import 'package:wonders/ui/common/scaling_list_item.dart';
import 'package:wonders/ui/common/themed_text.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration.dart';

part 'widgets/app_bar.dart';
part 'widgets/circular_title_bar.dart';
part 'widgets/collapsing_pull_quote_image.dart';
part 'widgets/sliding_image_stack.dart';
part 'widgets/scrolling_content.dart';
part 'widgets/section_divider.dart';
part 'widgets/title_text.dart';
part 'widgets/top_illustration.dart';

class WonderEditorialScreen extends StatefulWidget {
  const WonderEditorialScreen(this.data, {Key? key, required this.onScroll}) : super(key: key);
  final WonderData data;
  final void Function(double scrollPos) onScroll;

  @override
  State<WonderEditorialScreen> createState() => _WonderEditorialScreenState();
}

class _WonderEditorialScreenState extends State<WonderEditorialScreen> {
  late final ScrollController _scroller = ScrollController()..addListener(_handleScrollChanged);
  final _scrollPos = ValueNotifier(0.0);
  final _sectionIndex = ValueNotifier(0);
  final _showBottomListContent = ValueNotifier(false);
  final _scrollToPopThreshold = 70;
  bool _isPointerDown = false;

  @override
  void initState() {
    super.initState();
    // Delay initialization of some scrolling content for a moment, to give the hero time to fly.
    Future.delayed(.5.seconds).then((_) {
      if (!mounted) return;
      _showBottomListContent.value = true;
    });
  }

  @override
  void dispose() {
    _scroller.dispose();
    super.dispose();
  }

  /// Various [ValueListenableBuilders] are mapped to the _scrollPos and will rebuild when it changes
  void _handleScrollChanged() {
    _scrollPos.value = _scroller.position.pixels;
    widget.onScroll.call(_scrollPos.value);
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
      double _illustrationHeight = shortMode ? 250 : 330;
      double _minAppBarHeight = shortMode ? 40 : 120;
      double _maxAppBarHeight = shortMode ? 400 : 500;

      return NotificationListener<ScrollUpdateNotification>(
        onNotification: _checkPointerIsDown,
        child: ColoredBox(
          color: context.colors.bg,
          child: Stack(
            children: [
              /// Background
              Positioned.fill(
                child: ValueListenableBuilder(
                  valueListenable: _scrollPos,
                  builder: (_, value, __) {
                    return Container(
                      color: widget.data.type.bgColor.withOpacity(_scrollPos.value > 1000 ? 0 : 1),
                    );
                  },
                ),
              ),

              /// Top Illustration - Sits underneath the scrolling content, fades out as it scrolls
              SizedBox(
                height: _illustrationHeight,
                child: ValueListenableBuilder<double>(
                  valueListenable: _scrollPos,
                  builder: (_, value, child) {
                    // get some value between 0 and 1, based on the amt scrolled
                    double opacity = (1 - value / 500).clamp(0, 1);
                    return Opacity(opacity: opacity, child: child);
                  },
                  child: _TopIllustration(widget.data.type),
                ),
              ),

              /// Scrolling content - Includes an invisible gap at the top, and then scrolls over the illustration
              CustomScrollView(
                primary: false,
                controller: _scroller,
                cacheExtent: 100,
                physics: BouncingScrollPhysics(),
                slivers: [
                  /// Invisible padding at the top of the list, so the illustration shows through the btm
                  SliverToBoxAdapter(
                    child: SizedBox(height: _illustrationHeight + context.insets.md),
                  ),

                  /// Text content, animates itself to hide behind the app bar as it scrolls up
                  SliverToBoxAdapter(
                      child: ValueListenableBuilder<double>(
                          valueListenable: _scrollPos,
                          builder: (_, value, child) {
                            double offsetAmt = max(0, value * .3);
                            double opacity = (1 - offsetAmt / 150).clamp(0, 1);

                            return Transform.translate(
                              offset: Offset(0, offsetAmt),
                              child: Opacity(opacity: opacity, child: child),
                            );
                          },
                          child: _TitleText(widget.data))),

                  /// Collapsing App bar, pins to the top of the list
                  SliverAppBar(
                      pinned: true,
                      collapsedHeight: _minAppBarHeight,
                      toolbarHeight: _minAppBarHeight,
                      expandedHeight: _maxAppBarHeight,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: SizedBox.shrink(),
                      flexibleSpace: GTweener(
                        [GFade(), GMove(from: Offset(0, 100))],
                        duration: context.times.med,
                        // Fade the app bar in as we scroll up
                        child: ValueListenableBuilder<double>(
                          valueListenable: _scrollPos,
                          builder: (_, value, child) {
                            double opacity = (.4 + (value / 1000)).clamp(0, 1);
                            // Curve the opacity so it comes in a little later. Typically you wouldn't curve a fade
                            // but this is driven by the scroll position, so it works nicely.
                            return Opacity(opacity: Curves.easeIn.transform(opacity), child: child);
                          },
                          child: SizedBox.expand(
                            child: _AppBar(
                              widget.data.type,
                              scrollPos: _scrollPos,
                              sectionIndex: _sectionIndex,
                            ),
                          ),
                        ),
                      )
                      //ColoredBox(color: Colors.grey.shade200, child: Placeholder())
                      ),

                  /// Editorial content (text and images)
                  SliverToBoxAdapter(
                    child: ValueListenableBuilder<bool>(
                      // Hide content based on _showBottomListContent, helping to lighten the initial page load.
                      valueListenable: _showBottomListContent,
                      builder: (_, value, child) => value ? child! : SizedBox(height: 1000),
                      child: _ScrollingContent(widget.data, scrollPos: _scrollPos, sectionNotifier: _sectionIndex),
                    ),
                  ),

                  /// Bottom padding
                  SliverToBoxAdapter(
                    child: Container(height: 300, color: context.colors.bg),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}