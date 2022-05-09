part of '../timeline_screen.dart';

class _EventPopups extends StatefulWidget {
  const _EventPopups({Key? key, required this.currentEvent}) : super(key: key);
  final TimelineEvent? currentEvent;

  @override
  State<_EventPopups> createState() => _EventPopupsState();
}

class _EventPopupsState extends State<_EventPopups> {
  final _debouncer = Debouncer(500.ms);
  TimelineEvent? _eventToShow;

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
    return BottomCenter(
      child: ClipRect(
        child: IgnorePointer(
          child: AnimatedSwitcher(
            duration: context.times.fast,
            child: evt == null
                ? SizedBox.shrink()
                : FXAnimate(
                    fx: const [
                      SlideFX(begin: Offset(0, .1)),
                    ],
                    key: ValueKey(_eventToShow?.year),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.all(context.insets.md),
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
    );
  }
}
