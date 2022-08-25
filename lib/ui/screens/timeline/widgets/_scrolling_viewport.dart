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
  }) : super(key: key);
  final double minSize;
  final double maxSize;
  final ScrollController scroller;
  final WonderType? selectedWonder;
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
    return LayoutBuilder(builder: (_, constraints) {
      // cache constraints, so they can be used to maintain the selected year while zooming
      controller._constraints = constraints;
      double vtPadding = constraints.maxHeight / 2;
      double size = controller.calculateContentHeight();
      return GestureDetector(
        // Handle pinch to zoom
        onScaleUpdate: controller._handleScaleUpdate,
        onScaleStart: controller._handleScaleStart,
        behavior: HitTestBehavior.translucent,
        // Fade in entire view when first shown
        child: Animate(
          effects: const [FadeEffect()],
          child: Stack(
            children: [
              Column(
                children: [
                  /// Main scrolling area, holds the year markers, and the [WondersTimelineBuilder]
                  Expanded(
                    child: _buildScrollingArea(vtPadding, size, context, constraints),
                  ),
                  Gap($styles.insets.xs),

                  /// Era Text (classical, modern etc)
                  _buildAnimatedEraText(context),
                  Gap($styles.insets.xs),
                ],
              ),

              /// Dashed line with a year that changes as we scroll
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
        ),
      );
    });
  }

  AnimatedBuilder _buildAnimatedEraText(BuildContext context) {
    return AnimatedBuilder(
        animation: controller.scroller,
        builder: (_, __) {
          String era = StringUtils.getEra(controller.calculateYearFromScrollPos());
          final style = $styles.text.body.copyWith(color: $styles.colors.offWhite);
          return AnimatedSwitcher(
            duration: $styles.times.fast,
            child: Semantics(
                liveRegion: true,
                child: Text(era, key: ValueKey(era), style: style)
                    .animate(key: ValueKey(era))
                    .slide(begin: Offset(0, .2))),
          );
        });
  }

  Widget _buildScrollingArea(double vtPadding, double size, BuildContext context, BoxConstraints constraints) {
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

    return Stack(
      children: [
        SingleChildScrollView(
          controller: controller.scroller,
          padding: EdgeInsets.symmetric(vertical: vtPadding),
          // A stack inside a SizedBox which sets its overall height
          child: SizedBox(
            height: size,
            width: double.infinity,
            child: Stack(
              children: [
                /// Year Markers
                _YearMarkers(),

                /// individual timeline sections
                Positioned.fill(
                  left: 100,
                  right: $styles.insets.sm,
                  child: FocusTraversalGroup(
                    child: WondersTimelineBuilder(
                        axis: Axis.vertical,
                        crossAxisGap: max(6, (constraints.maxWidth - (120 * 3)) / 2),
                        minSize: _minTimelineSize,
                        timelineBuilder: (_, data, __) => buildTimelineSection(data)),
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
  }
}
