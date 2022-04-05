import 'dart:async';

import 'package:flutter_circular_text/circular_text.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/arch_clipper.dart';
import 'package:wonders/ui/common/controls/eight_way_swipe_detector.dart';
import 'package:wonders/ui/common/placeholder_image.dart';
import 'package:wonders/ui/common/placeholder_text.dart';
import 'package:wonders/ui/common/themed_text.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration.dart';

part 'circular_title_bar.dart';
part 'editorial_app_bar.dart';
part 'editorial_content.dart';
part 'editorial_illustration.dart';
part 'editorial_title.dart';

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

  @override
  void dispose() {
    _scroller.dispose();
    super.dispose();
  }

  /// Various [ValueListenableBuilders] are mapped to the _scrollPos and will rebuild when it changes
  void _handleScrollChanged() {
    _scrollPos.value = _scroller.position.pixels;
    widget.onScroll.call(_scrollPos.value);
  }

  /// Listen for up-swipe to go back to home
  void _handleListTopSwipe(Offset dir) {
    if (dir == Offset(0, 1)) context.pop();
  }

  /// Notifications bubble up from the scolling content, and this value gets passed into the
  /// app bar, so it can change titles as we scroll.
  void _handleSectionChangedNotification(int value) {
    _sectionIndex.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      bool shortMode = constraints.biggest.height < 700;
      double _illustrationHeight = shortMode ? 250 : 330;
      double _minAppBarHeight = shortMode ? 40 : 120;
      double _maxAppBarHeight = shortMode ? 400 : 500;

      return NotificationListener(
        onNotification: (SectionChangedNotification n) {
          _handleSectionChangedNotification(n.index);
          return true;
        },
        child: ColoredBox(
          color: context.colors.wonderBg(widget.data.type),
          child: Stack(
            children: [
              /// Illustration - Sits underneath the scrolling content, fades out as it scrolls
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
                physics: ClampingScrollPhysics(),
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
                            //TODO: This needs to take the actual image, not an id
                            child: _EditorialAppBar(
                              widget.data.type,
                              imageId: 'VPavA7BBxK0',
                              sectionIndex: _sectionIndex,
                            ),
                          ),
                        ),
                      )
                      //ColoredBox(color: Colors.grey.shade200, child: Placeholder())
                      ),

                  /// Editorial content (text and images)
                  SliverToBoxAdapter(child: _EditorialContent(widget.data, scrollNotifier: _scrollPos)),

                  /// Bottom padding
                  SliverToBoxAdapter(child: Container(height: 100, color: context.colors.bg)),
                ],
              ),

              /// Invisible hit area that sits on top of the list when it is scrolled all the way to the top
              /// Enables a swipe down gesture, to go back to the home page. Otherwise the scroll view will absorb any vertical swipes.
              ValueListenableBuilder<double>(
                valueListenable: _scrollPos,
                builder: (_, value, child) => (value > 0) ? SizedBox.shrink() : child!,
                child: SizedBox(
                  height: _illustrationHeight,
                  width: double.infinity,
                  child: EightWaySwipeDetector(
                    onSwipe: _handleListTopSwipe,
                    child: ColoredBox(color: Colors.red.withOpacity(0)),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class SectionChangedNotification extends Notification {
  SectionChangedNotification(this.index);
  final int index;
}
