part of '../wonder_events.dart';

class _EventsList extends StatefulWidget {
  const _EventsList({
    Key? key,
    required this.data,
    this.topHeight = 0,
    this.blurOnScroll = false,
    this.showTopGradient = true,
    required this.initialScrollOffset,
    required this.onScroll,
  }) : super(key: key);
  final WonderData data;
  final double topHeight;
  final bool blurOnScroll;
  final bool showTopGradient;
  final double initialScrollOffset;
  final void Function(double offset) onScroll;
  @override
  State<_EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<_EventsList> {
  late final ScrollController _scroller = ScrollController(initialScrollOffset: widget.initialScrollOffset)
    ..addListener(() => widget.onScroll(_scroller.offset));

  @override
  void dispose() {
    _scroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(child: widget.blurOnScroll ? _buildScrollingListWithBlur() : _buildScrollingList());
  }

  /// The actual content of the scrolling list
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
        TimelineEventCard(year: e.key, text: e.value, darkMode: true)
            .animate()
            .fade(delay: delay, duration: $styles.times.med * 1.5)
            .slide(begin: Offset(0, 1), curve: Curves.easeOutBack),
      );
    }
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scroller,
          key: PageStorageKey('eventsList'),
          child: Column(
            children: [
              IgnorePointer(child: Gap(widget.topHeight)),
              Container(
                decoration: BoxDecoration(
                  color: $styles.colors.black,
                  borderRadius: BorderRadius.circular($styles.corners.md),
                ),
                padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
                child: Column(
                  children: [
                    Gap($styles.insets.xs),
                    buildHandle(),
                    Gap($styles.insets.sm),
                    ...listItems,
                    Gap($styles.insets.xl),
                    HiddenCollectible(widget.data.type, index: 2, size: 150),
                    Gap(150),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (widget.showTopGradient)
          Positioned.fill(
            child: TopCenter(
              child: ListOverscollGradient(size: 100),
            ),
          ),
      ],
    );
  }

  /// Wraps the list in a scroll listener that fades in an underlay as the content
  /// is scrolled
  Widget _buildScrollingListWithBlur() {
    return AnimatedBuilder(
      animation: _scroller,
      child: _buildScrollingList(),
      builder: (_, child) {
        bool showBackdrop = true;
        double backdropAmt = 0;
        if (_scroller.hasClients && showBackdrop) {
          double blurStart = 50;
          double maxScroll = 300;
          double scrollPx = _scroller.position.pixels - blurStart;
          // Normalize scroll position to a value between 0 and 1
          backdropAmt = (_scroller.position.pixels - blurStart).clamp(0, maxScroll) / maxScroll;
          // Disable backdrop once it is offscreen for an easy perf win
          showBackdrop = (scrollPx <= 1000);
        }
        // Container provides a underlay which gets darker as the background blurs
        return Stack(
          children: [
            if (showBackdrop) ...[
              AppBackdrop(
                  strength: backdropAmt,
                  child: IgnorePointer(
                    child: Container(
                      color: $styles.colors.black.withOpacity(backdropAmt * .6),
                    ),
                  )),
            ],
            child!,
          ],
        );
      },
    );
  }
}
