part of '../timeline_screen.dart';

class _BottomScrubber extends StatelessWidget {
  const _BottomScrubber(this.scroller, {Key? key, required this.timelineMinSize, required this.size}) : super(key: key);
  final ScrollController scroller;
  final double timelineMinSize;
  final double size;

  @override
  Widget build(BuildContext context) {
    void _handleScrubberPan(DragUpdateDetails details) {
      if (!scroller.hasClients) return;
      // TODO: This drag multiplier is close... but not exactly right.
      double dragMultiplier = (scroller.position.maxScrollExtent + timelineMinSize) / context.widthPx;
      double newPos = scroller.position.pixels + details.delta.dx * dragMultiplier;
      scroller.position.jumpTo(newPos.clamp(0, scroller.position.maxScrollExtent));
    }

    return Stack(
      children: [
        Placeholder(fallbackHeight: size),
        AnimatedBuilder(
          animation: scroller,
          builder: (_, __) {
            // Get current scroll offset and move the viewport to match
            double scrollOffset = 0;
            double viewPort = 1;
            // SB: Need to add these checks because Flutter throws an error out if you ask it for scroll position when hasClients=false
            // TODO: Can we abstract this so that the views don't need to care about this?... all we want is a couple of doubles
            if (scroller.hasClients) {
              if (scroller.position.maxScrollExtent > 0) {
                scrollOffset = scroller.position.pixels / scroller.position.maxScrollExtent;
              }
              // print(scroller.position.maxScrollExtent);
              final viewportSize = scroller.position.viewportDimension;
              viewPort = viewportSize / (scroller.position.maxScrollExtent + viewportSize);
              viewPort = viewPort.clamp(0, 1);
              //print(viewPort);
            }
            return Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onPanUpdate: _handleScrubberPan,
                child: Align(
                  alignment: Alignment(-1 + scrollOffset * 2, 0),
                  child: FractionallySizedBox(
                    child: ColoredBox(color: Colors.red.withOpacity(.3)),
                    widthFactor: viewPort,
                    heightFactor: 1,
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
