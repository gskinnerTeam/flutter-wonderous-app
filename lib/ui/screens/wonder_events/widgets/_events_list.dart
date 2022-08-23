part of '../wonder_events.dart';

class _EventsList extends StatefulWidget {
  const _EventsList({Key? key, required this.data}) : super(key: key);
  final WonderData data;

  @override
  State<_EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<_EventsList> {
  late final ScrollController _scroller = ScrollController()..addListener(_handleScrollChanged);
  bool _hasPopped = false;
  bool _isPointerDown = false;
  @override
  void dispose() {
    _scroller.dispose();
    super.dispose();
  }

  void _handleScrollChanged() {
    if (!_isPointerDown) return;
    if (_scroller.position.pixels < -100 && !_hasPopped) {
      _hasPopped = true;
      context.pop();
    }
  }

  bool _checkPointerIsDown(d) => _isPointerDown = d.dragDetails != null;

  void _handleGlobalTimelinePressed() => context.push(ScreenPaths.timeline(widget.data.type));

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: _checkPointerIsDown,
      child: LayoutBuilder(builder: (_, constraints) {
        return Stack(
          children: [
            AnimatedBuilder(
              animation: _scroller,
              builder: (_, __) {
                bool showBackdrop = true;
                double backdropAmt = 0;
                if (_scroller.hasClients) {
                  double blurStart = 50;
                  double maxScroll = 150;
                  double scrollPx = _scroller.position.pixels - blurStart;
                  // Normalize scroll position to a value between 0 and 1
                  backdropAmt = (_scroller.position.pixels - blurStart).clamp(0, maxScroll) / maxScroll;
                  // Disable backdrop once it is offscreen for an easy perf win
                  showBackdrop = (scrollPx <= 500);
                }
                // Container provides a underlay which gets darker as the background blurs
                return Stack(
                  children: [
                    if (showBackdrop) ...[
                      AppBackdrop(
                          strength: backdropAmt,
                          child: IgnorePointer(
                            child: Container(
                              color: $styles.colors.greyStrong.withOpacity(backdropAmt * .6),
                            ),
                          )),
                    ],
                    _buildScrollingList()
                  ],
                );
              },
            ),
          ],
        );
      }),
    );
  }

  Widget _buildScrollingList() {
    Container buildHandle() {
      return Container(
        width: 35,
        height: 5,
        decoration: BoxDecoration(color: $styles.colors.greyMedium, borderRadius: BorderRadius.circular(99)),
      );
    }

    final events = widget.data.events;

    final listItems = <Widget>[];
    for (var e in events.entries) {
      final delay = 100.ms + (100 * listItems.length).ms;
      listItems.add(
        TimelineEventCard(year: e.key, text: e.value)
            .animate()
            .fade(delay: delay, duration: $styles.times.med * 1.5)
            .slide(begin: Offset(0, 1), curve: Curves.easeOutBack),
      );
    }
    return SingleChildScrollView(
      controller: _scroller,
      child: Column(
        children: [
          IgnorePointer(child: Gap(WonderEvents._topHeight)),
          Container(
            decoration: BoxDecoration(
              color: $styles.colors.white,
              borderRadius: BorderRadius.circular($styles.corners.md),
            ),
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
            child: Column(
              children: [
                Gap($styles.insets.xs),
                buildHandle(),
                Gap($styles.insets.sm),
                ...listItems,
                Gap($styles.insets.lg),
                AppBtn.from(
                  text: $strings.eventsListButtonOpenGlobal,
                  expand: true,
                  onPressed: _handleGlobalTimelinePressed,
                  semanticLabel: $strings.eventsListButtonOpenGlobal,
                ),
                Gap($styles.insets.xl),
                CompassDivider(isExpanded: true),
                Gap($styles.insets.md),
                HiddenCollectible(widget.data.type, index: 2, size: 150),
                Gap(150),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
