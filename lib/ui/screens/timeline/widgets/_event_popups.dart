part of '../timeline_screen.dart';

class _EventPopups extends StatefulWidget {
  const _EventPopups({required this.currentEvent});
  final TimelineEvent? currentEvent;

  @override
  State<_EventPopups> createState() => _EventPopupsState();
}

class _EventPopupsState extends State<_EventPopups> {
  final _debouncer = Debouncer(500.animateMs);
  TimelineEvent? _eventToShow;

  @override
  void dispose() {
    _debouncer.reset();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _EventPopups oldWidget) {
    super.didUpdateWidget(oldWidget);
    _debouncer.call(showCardForCurrentYr);
  }

  void showCardForCurrentYr() {
    setState(() {
      _eventToShow = widget.currentEvent;
    });
  }

  @override
  Widget build(BuildContext context) {
    final evt = _eventToShow;
    // At large text sizes the card is taller than the viewport, so it gets a wider layout with a capped, scrollable height.
    final bool largeText = MediaQuery.textScalerOf(context).scale(1) >= TimelineEventCard.stackedTextScale;
    return LayoutBuilder(
      builder: (_, constraints) {
        Widget buildPopup(TimelineEvent evt) {
          if (!largeText) {
            return IntrinsicHeight(
              child: SizedBox(
                width: $styles.sizes.maxContentWidth3,
                child: Padding(
                  padding: EdgeInsets.all($styles.insets.md),
                  child: TimelineEventCard(text: evt.description, year: evt.year),
                ),
              ),
            );
          }
          // Stop just above the centre-line year label, which sits directly above the middle of this viewport.
          final double maxHeight = max(
            0.0,
            constraints.maxHeight / 2 - _DashedDividerWithYear.largeTextHeight - $styles.insets.xs,
          );
          return SizedBox(
            // Matches WonderEvents: use most of the screen width on tablets.
            width: max($styles.sizes.maxContentWidth3, constraints.maxWidth * .9),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxHeight),
              child: Scrollbar(
                child: SingleChildScrollView(
                  primary: false,
                  padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.xs),
                  // Compact one-line year so the description is visible without scrolling on phones.
                  child: TimelineEventCard(text: evt.description, year: evt.year, compactYear: true),
                ),
              ),
            ),
          );
        }

        final Widget content = AnimatedSwitcher(
          duration: $styles.times.fast,
          child: evt == null
              ? SizedBox.shrink()
              : Semantics(
                  liveRegion: true,
                  child: Animate(
                    effects: const [
                      SlideEffect(begin: Offset(0, -.1)),
                    ],
                    key: ValueKey(evt.year),
                    child: buildPopup(evt),
                  ),
                ),
        );

        return TopCenter(
          child: ClipRect(
            // At large text sizes the popup must accept touches so its text can be scrolled.
            child: largeText ? content : IgnorePointerKeepSemantics(child: content),
          ),
        );
      },
    );
  }
}
