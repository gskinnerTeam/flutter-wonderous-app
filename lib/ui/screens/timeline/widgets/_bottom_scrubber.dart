part of '../timeline_screen.dart';

class _BottomScrubber extends StatelessWidget {
  const _BottomScrubber(this.scroller,
      {Key? key, required this.timelineMinSize, required this.size, required this.selectedWonder})
      : super(key: key);
  final ScrollController? scroller;
  final double timelineMinSize;
  final double size;
  final WonderType? selectedWonder;

  /// Calculate what fraction the scroller has travelled
  double _calculateScrollFraction(ScrollPosition? pos) {
    if (pos == null || pos.maxScrollExtent == 0) return 0;
    return pos.pixels / pos.maxScrollExtent;
  }

  /// Calculates what fraction of the scroller is current visible
  double _calculateViewPortFraction(ScrollPosition? pos) {
    if (pos == null) return 1;
    final viewportSize = pos.viewportDimension;
    final result = viewportSize / (pos.maxScrollExtent + viewportSize);
    return result.clamp(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    final scroller = this.scroller;

    /// It might take a frame until we receive a valid scroller
    if (scroller == null) return SizedBox.shrink();
    void handleScrubberPan(DragUpdateDetails details) {
      if (!scroller.hasClients) return;
      double dragMultiplier = (scroller.position.maxScrollExtent + timelineMinSize) / context.widthPx;
      double newPos = scroller.position.pixels + details.delta.dx * dragMultiplier;
      scroller.position.jumpTo(newPos.clamp(0, scroller.position.maxScrollExtent));
    }

    return SizedBox(
      height: size,
      child: Stack(
        children: [
          /// Timeline background
          Padding(
            padding: EdgeInsets.all($styles.insets.sm),
            child: WondersTimelineBuilder(
              crossAxisGap: 4,
              selectedWonders: selectedWonder != null ? [selectedWonder!] : [],
            ),
          ),

          /// Visible area, follows the position of scroller
          AnimatedBuilder(
            animation: scroller,
            builder: (_, __) {
              ScrollPosition? pos;
              if (scroller.hasClients) pos = scroller.position;
              // Get current scroll offset and move the viewport to match
              double scrollFraction = _calculateScrollFraction(pos);
              double viewPortFraction = _calculateViewPortFraction(pos);
              final scrubberAlign = Alignment(-1 + scrollFraction * 2, 0);

              return Positioned.fill(
                child: Semantics(
                  container: true,
                  slider: true,
                  label: $strings.bottomScrubberSemanticTimeline,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onPanUpdate: handleScrubberPan,

                    /// Scrub area
                    child: Align(
                      alignment: scrubberAlign,
                      child: FractionallySizedBox(
                        widthFactor: viewPortFraction,
                        heightFactor: 1,
                        child: _buildOutlineBox(context, scrubberAlign),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Container _buildOutlineBox(BuildContext context, Alignment alignment) {
    final borderColor = $styles.colors.white;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: borderColor)),
      child: Align(alignment: alignment, child: DashedLine(vertical: true)),
    );
  }
}
