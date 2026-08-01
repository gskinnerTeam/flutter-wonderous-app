part of '../timeline_screen.dart';

/// A vertically aligned stack of dots that represent global events
/// The event closest to the [selectedYr] param will be visible selected
class _EventMarkers extends StatefulWidget {
  const _EventMarkers({
    super.key,
    required this.onEventChanged,
    required this.onMarkerPressed,
  });

  final void Function(TimelineEvent? event) onEventChanged;
  final void Function(TimelineEvent event) onMarkerPressed;

  @override
  State<_EventMarkers> createState() => _EventMarkersState();
}

class _EventMarkersState extends State<_EventMarkers> {
  bool get showReferenceMarkers => kDebugMode;
  int get startYr => wondersLogic.timelineStartYear;

  int get endYr => wondersLogic.timelineEndYear;

  late final int _totalYrs = endYr - startYr;

  TimelineEvent? selectedEvent;

  /// Normalizes a given year to a value from 0 - 1, based on start and end yr.
  double _calculateOffsetY(int yr) => (yr - startYr) / _totalYrs;

  late BoxConstraints _constraints;

  /// Loops through the global events, and does a px-based check to see whether
  /// one of them should be selected  (as oppose to year-based proximity).
  /// This ensures consistent UX at different zoom levels.
  void _updateSelectedEvent() {
    const double minDistance = 10;
    TimelineEvent? closestEvent;
    double closestDistance = double.infinity;
    // Convert current yr to a px position
    double currentYearPx = _calculateOffsetY(_notifier.value) * _constraints.maxHeight;
    for (var e in timelineLogic.events) {
      // Convert both the event.yr to px, and compare with currentYearPx
      double eventPx = _eventOffsetCache[e]! * _constraints.maxHeight;
      double d = (eventPx - currentYearPx).abs();
      // Keep the closest event that is within minDistance
      if (d <= minDistance && d < closestDistance) {
        closestEvent = e;
        closestDistance = d;
      }
    }
    // Dispatch if event has actually changed since last time
    if (closestEvent != selectedEvent) {
      scheduleMicrotask(() => widget.onEventChanged(closestEvent));
      setState(() => selectedEvent = closestEvent);
    }
  }

  //Calculate the offsets for each event only once
  late final Map<TimelineEvent, double> _eventOffsetCache = Map.fromEntries(
    timelineLogic.events.map((e) => MapEntry(e, _calculateOffsetY(e.year))),
  );

  //Store reference to the notifier for listeners
  late final CurrentYearNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = context.read<CurrentYearNotifier>();
    _notifier.addListener(_updateSelectedEvent);
  }

  @override
  void dispose() {
    _notifier.removeListener(_updateSelectedEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointerKeepSemantics(
      child: LayoutBuilder(
        builder: (_, constraints) {
          //Store latest constraints in local variable
          _constraints = constraints;

          /// Create a marker for each event
          final markers = timelineLogic.events.map((event) {
            double offsetY = _eventOffsetCache[event]!;
            return _EventMarker(
              offsetY,
              event: event,
              isSelected: event == selectedEvent,
              onPressed: widget.onMarkerPressed,
            );
          });

          /// Stack of fractionally positioned markers
          return FocusTraversalGroup(
            policy: WidgetOrderTraversalPolicy(),
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 75),
              child: SizedBox(
                width: 20,
                child: Stack(
                  children: [
                    ...markers,
                    if (showReferenceMarkers) ..._buildReferenceMarkers(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildReferenceMarkers() {
    final marker = Container(color: Colors.red.withValues(alpha: .4), width: 10, height: 10);
    return [
      Align(
        alignment: Alignment.topCenter,
        child: FractionalTranslation(translation: Offset(0, -.5), child: marker),
      ),
      Align(alignment: Alignment.center, child: marker),
      Align(
        alignment: Alignment.bottomCenter,
        child: FractionalTranslation(translation: Offset(0, .5), child: marker),
      ),
    ];
  }
}

/// A dot that represents a single global event.
/// Animated to a selected state which is is larger in size.
class _EventMarker extends StatelessWidget {
  const _EventMarker(
    this.offset, {
    super.key,
    required this.isSelected,
    required this.event,
    required this.onPressed,
  });
  final double offset;
  final TimelineEvent event;
  final bool isSelected;
  final void Function(TimelineEvent event) onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -1 + offset * 2),
      // Use an OverflowBox wrapped in a zero-height sized box so that al
      // This allows alignment-based positioning to be accurate even at the edges of the parent.
      child: SizedBox(
        height: 0,
        child: OverflowBox(
          maxHeight: 30,
          child: AppBtn.basic(
            semanticLabel: '${event.year}: ${event.description}',
            onPressed: () => onPressed(event),
            child: Container(
              alignment: Alignment.center,
              height: 30,
              child: AnimatedContainer(
                width: isSelected ? 6 : 2,
                height: isSelected ? 6 : 2,
                curve: Curves.easeOutBack,
                duration: $styles.times.med,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: $styles.colors.accent1,
                  boxShadow: [
                    BoxShadow(
                      color: $styles.colors.accent1.withValues(alpha: isSelected ? .5 : 0),
                      spreadRadius: 3,
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
