part of '../timeline_screen.dart';

class _BottomScrubber extends StatelessWidget {
  const _BottomScrubber(this.scroller, {Key? key, required this.timelineMinSize, required this.size}) : super(key: key);
  final ScrollController? scroller;
  final double timelineMinSize;
  final double size;

  double _calculateScrollFraction(ScrollPosition? pos) {
    if (pos == null || pos.maxScrollExtent == 0) return 0;
    return pos.pixels / pos.maxScrollExtent;
  }

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
    void _handleScrubberPan(DragUpdateDetails details) {
      if (!scroller.hasClients) return;
      // TODO: This drag multiplier is close... but not exactly right.
      double dragMultiplier = (scroller.position.maxScrollExtent + timelineMinSize) / context.widthPx;
      double newPos = scroller.position.pixels + details.delta.dx * dragMultiplier;
      scroller.position.jumpTo(newPos.clamp(0, scroller.position.maxScrollExtent));
    }

    return SizedBox(
      height: size,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(context.insets.sm),
            child: WondersTimelineBuilder(
              crossAxisGap: 8,
              timelineBuilder: (_, data) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(color: context.colors.greyMedium),
                  ),
                );
              },
            ),
          ),
          AnimatedBuilder(
            animation: scroller,
            builder: (_, __) {
              ScrollPosition? pos;
              if (scroller.hasClients) pos = scroller.position;
              // Get current scroll offset and move the viewport to match
              double scrollFraction = _calculateScrollFraction(pos);
              double viewPortFraction = _calculateViewPortFraction(pos);

              return Positioned.fill(
                child: Semantics(
                  container: true,
                  button: true,
                  label: 'scrubber',
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onPanUpdate: _handleScrubberPan,
                    child: Align(
                      alignment: Alignment(-1 + scrollFraction * 2, 0),
                      child: FractionallySizedBox(
                        child: ColoredBox(color: Colors.red.withOpacity(.3), child: Text('')),
                        widthFactor: viewPortFraction,
                        heightFactor: 1,
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
}
