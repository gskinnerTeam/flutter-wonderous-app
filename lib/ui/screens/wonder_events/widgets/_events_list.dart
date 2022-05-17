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
                double blur = 0;
                double scrollAmt = 0;
                if (_scroller.hasClients) {
                  double blurStart = 100;
                  scrollAmt = (_scroller.position.pixels - blurStart).clamp(0, 50) / 50;
                  blur = scrollAmt * 10;
                }
                // Container provides a underlay which gets darker as the background blurs
                return Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                      child: IgnorePointer(
                        child: Container(
                          color: context.colors.greyStrong.withOpacity(min(1, scrollAmt * 2) * .5),
                        ),
                      ),
                    ),
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
        decoration: BoxDecoration(color: context.colors.greyMedium, borderRadius: BorderRadius.circular(99)),
      );
    }

    final events = widget.data.events;

    final listItems = <Widget>[];
    for (var e in events.entries) {
      final delay = 100.ms + (100 * listItems.length).ms;
      listItems.add(
        TimelineEventCard(year: e.key, text: e.value)
            .fx()
            .fade(delay: delay, duration: context.times.med * 1.5)
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
              color: context.colors.white,
              borderRadius: BorderRadius.circular(context.corners.md),
            ),
            padding: EdgeInsets.symmetric(horizontal: context.insets.md),
            child: Column(
              children: [
                Gap(context.insets.xs),
                buildHandle(),
                Gap(context.insets.sm),
                ...listItems,
                Gap(context.insets.lg),
                AppBtn.from(
                  text: 'Open global timeline',
                  expand: true,
                  onPressed: _handleGlobalTimelinePressed,
                  semanticLabel: 'Open global timeline',
                ),
                Gap(context.insets.xl),
                CompassDivider(isExpanded: true),
                Gap(context.insets.md),
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
