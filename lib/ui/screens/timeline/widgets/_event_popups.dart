part of '../timeline_screen.dart';

class _EventPopups extends StatefulWidget {
  const _EventPopups({super.key, required this.currentEvent});
  final TimelineEvent? currentEvent;

  @override
  State<_EventPopups> createState() => _EventPopupsState();
}

class _EventPopupsState extends State<_EventPopups> {
  final _debouncer = Debouncer(500.ms);
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
    return TopCenter(
      child: ClipRect(
        child: IgnorePointer(
          ignoringSemantics: false,
          child: AnimatedSwitcher(
            duration: $styles.times.fast,
            child: evt == null
                ? SizedBox.shrink()
                : Semantics(
                    liveRegion: true,
                    child: Animate(
                      effects: const [
                        SlideEffect(begin: Offset(0, -.1)),
                      ],
                      key: ValueKey(_eventToShow?.year),
                      child: IntrinsicHeight(
                        child: SizedBox(
                          width: $styles.sizes.maxContentWidth3,
                          child: Padding(
                            padding: EdgeInsets.all($styles.insets.md),
                            child: TimelineEventCard(
                              text: evt.description,
                              year: evt.year,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
