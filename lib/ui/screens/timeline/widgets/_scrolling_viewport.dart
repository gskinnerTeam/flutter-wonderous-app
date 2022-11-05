part of '../timeline_screen.dart';

class _ScrollingViewport extends StatefulWidget {
  const _ScrollingViewport({
    Key? key,
    // ignore: unused_element
    this.onInit,
    required this.scroller,
    required this.minSize,
    required this.maxSize,
    required this.selectedWonder,
    this.onYearChanged,
  }) : super(key: key);
  final double minSize;
  final double maxSize;
  final ScrollController scroller;
  final WonderType? selectedWonder;
  final void Function(int year)? onYearChanged;
  final void Function(_ScrollingViewportController controller)? onInit;

  @override
  State<_ScrollingViewport> createState() => _ScalingViewportState();
}

class _ScalingViewportState extends State<_ScrollingViewport> {
  late final _ScrollingViewportController controller = _ScrollingViewportController(this);
  static const double _minTimelineSize = 100;
  final _currentEventMarker = ValueNotifier<TimelineEvent?>(null);

  @override
  void initState() {
    super.initState();
    controller.init();
    widget.onInit?.call(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleEventMarkerChanged(TimelineEvent? event) {
    _currentEventMarker.value = event;
    AppHaptics.selectionClick();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Handle pinch to zoom
      onScaleUpdate: controller._handleScaleUpdate,
      onScaleStart: controller._handleScaleStart,
      behavior: HitTestBehavior.translucent,
      // Fade in entire view when first shown
      child: Stack(
        children: [
          // Main content area
          _buildScrollingArea(context).animate().fadeIn(),

          // Dashed line with a year that changes as we scroll
          IgnorePointer(
            ignoringSemantics: false,
            child: AnimatedBuilder(
              animation: controller.scroller,
              builder: (_, __) {
                return _DashedDividerWithYear(controller.calculateYearFromScrollPos());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollingArea(BuildContext context) {
    // Builds a TimelineSection, and passes it the currently selected yr based on scroll position.
    // Rebuilds when timeline is scrolled.
    Widget buildTimelineSection(WonderData data) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: AnimatedBuilder(
          animation: controller.scroller,
          builder: (_, __) => TimelineSection(
            data,
            controller.calculateYearFromScrollPos(),
            selectedWonder: widget.selectedWonder,
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (_, constraints) {
        // cache constraints, so they can be used to maintain the selected year while zooming
        controller._constraints = constraints;
        double vtPadding = constraints.maxHeight / 2;
        double size = controller.calculateContentHeight();
        final contentSize = min($styles.sizes.maxContentWidth2, constraints.maxWidth);
        return Stack(
          children: [
            SingleChildScrollView(
              controller: controller.scroller,
              padding: EdgeInsets.symmetric(vertical: vtPadding),
              // A stack inside a SizedBox which sets its overall height
              child: Center(
                child: SizedBox(
                  height: size,
                  width: contentSize,
                  child: Stack(
                    children: [
                      /// Year Markers
                      _YearMarkers(),

                      /// individual timeline sections
                      Positioned.fill(
                        left: 100,
                        right: $styles.insets.sm,
                        child: FocusTraversalGroup(
                          //child: Placeholder(),
                          child: WondersTimelineBuilder(
                            axis: Axis.vertical,
                            crossAxisGap: max(6, (contentSize - (120 * 3)) / 2),
                            minSize: _minTimelineSize,
                            timelineBuilder: (_, data, __) => buildTimelineSection(data),
                          ),
                        ),
                      ),

                      /// Event Markers, rebuilds on scroll
                      AnimatedBuilder(
                        animation: controller.scroller,
                        builder: (_, __) => _EventMarkers(
                          controller.calculateYearFromScrollPos(),
                          onEventChanged: _handleEventMarkerChanged,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// Top and bottom gradients for visual style
            ListOverscollGradient(),
            BottomCenter(
              child: ListOverscollGradient(bottomUp: true),
            ),

            /// Event Popups, rebuilds when [_currentEventMarker] changes
            ValueListenableBuilder<TimelineEvent?>(
                valueListenable: _currentEventMarker,
                builder: (_, data, __) {
                  return _EventPopups(currentEvent: data);
                })
          ],
        );
      },
    );
  }
}
