part of '../timeline_screen.dart';

class _ScalingViewport extends StatefulWidget {
  const _ScalingViewport({
    Key? key,
    this.onInit,
    required this.scroller,
    required this.minSize,
    required this.maxSize,
    required this.startYr,
    required this.endYr,
  }) : super(key: key);
  final double minSize;
  final double maxSize;
  final int startYr;
  final int endYr;
  final ScrollController scroller;
  final void Function(_ScalingViewportController controller)? onInit;

  @override
  State<_ScalingViewport> createState() => ScalingViewportState();
}

class ScalingViewportState extends State<_ScalingViewport> {
  late final _ScalingViewportController controller = _ScalingViewportController(this);

  @override
  void initState() {
    super.initState();
    widget.onInit?.call(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // cache constraints, so they can be used to maintain the selected year while zooming
      controller._constraints = constraints;
      double vtPadding = constraints.maxHeight / 2;
      double size = controller.calculateContentHeight();
      return GestureDetector(
        onScaleUpdate: controller._handleScaleUpdate,
        onScaleStart: controller._handleScaleStart,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          fit: StackFit.expand,
          children: [
            /// The scrolling content itself
            SingleChildScrollView(
              controller: controller.scroller,
              padding: EdgeInsets.symmetric(vertical: vtPadding),
              // A stack inside a SizedBox which sets its overall height
              child: SizedBox(
                height: size,
                child: Stack(
                  children: [
                    /// Year Markers
                    _YearMarkers(startYr: widget.startYr, endYr: widget.endYr),

                    /// The individual timelines
                    Positioned.fill(
                      left: 100,
                      right: context.insets.sm,
                      child: WondersTimelineBuilder(
                          axis: Axis.vertical,
                          crossAxisGap: 24,
                          minSize: 110,
                          timelineBuilder: (_, data) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(99),
                              child: AnimatedBuilder(
                                animation: controller.scroller,
                                builder: (_, __) => TimelineSection(
                                  data,
                                  controller.calculateYearFromScrollPos(),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),

            /// Dashed line with a year that changes as we scroll
            AnimatedBuilder(
              animation: controller.scroller,
              builder: (_, __) => _DashedDividerWithYear(controller.calculateYearFromScrollPos()),
            ),
          ],
        ),
      );
    });
  }
}
