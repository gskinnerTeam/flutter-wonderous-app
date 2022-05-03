part of '../timeline_screen.dart';

class _ScrollingViewport extends StatefulWidget {
  const _ScrollingViewport({
    Key? key,
    this.onInit,
    required this.scroller,
    required this.minSize,
    required this.maxSize,
    required this.selectedWonder,
  }) : super(key: key);
  final double minSize;
  final double maxSize;
  final ScrollController scroller;
  final WonderType selectedWonder;
  final void Function(_ScrollingViewportController controller)? onInit;

  @override
  State<_ScrollingViewport> createState() => ScalingViewportState();
}

class ScalingViewportState extends State<_ScrollingViewport> {
  late final _ScrollingViewportController controller = _ScrollingViewportController(this);
  static const double _minTimelineSize = 100;

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
        behavior: HitTestBehavior.opaque,
        // Fade in entire view when first shown
        child: FXAnimate(
          fx: const [FadeFX()],
          child: Stack(
            children: [
              Column(
                children: [
                  /// Main scrolling area, holds the year markers, and the [WondersTimelineBuilder]
                  Expanded(
                    child: _buildScrollingStack(vtPadding, size, context, constraints),
                  ),
                  Gap(context.insets.xs),

                  /// Era Text
                  _buildAnimatedEraText(context),
                  Gap(context.insets.xs),
                ],
              ),

              /// Dashed line with a year that changes as we scroll
              IgnorePointer(
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
          final style = context.text.body.copyWith(color: context.colors.offWhite);
          return AnimatedSwitcher(
            duration: context.times.fast,
            child: Text(era, key: ValueKey(era), style: style).fx(key: ValueKey(era)).slide(begin: Offset(0, .2)),
          );
        });
  }

  Widget _buildScrollingStack(double vtPadding, double size, BuildContext context, BoxConstraints constraints) {
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

                /// The individual timelines
                Positioned.fill(
                  left: 100,
                  right: context.insets.sm,
                  child: WondersTimelineBuilder(
                      axis: Axis.vertical,
                      crossAxisGap: max(6, (constraints.maxWidth - (120 * 3)) / 2),
                      minSize: _minTimelineSize,
                      timelineBuilder: (_, data, __) {
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
                      }),
                ),

                /// Events
                _EventMarkers(),
              ],
            ),
          ),
        ),
        ListOverscollGradient(),
        BottomCenter(
          child: ListOverscollGradient(bottomUp: true),
        ),
      ],
    );
  }
}
