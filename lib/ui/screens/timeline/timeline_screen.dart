import 'dart:ui';

import 'package:wonders/common_libs.dart';

class TimelineScreen extends StatefulWidget {
  final WonderType type;

  const TimelineScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  final ScrollController _scroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // Determine min and max size of the timeline based on the size available to this widget
      const scrubberSize = 150.0;
      final minSize = constraints.biggest.height - scrubberSize;
      final maxSize = constraints.biggest.height * 3;
      return Column(
        children: [
          /// Vertically scrolling timeline, manages a ScrollController.
          Expanded(
            child: _Viewport(controller: _scroller, minSize: minSize, maxSize: maxSize),
          ),

          /// Mini Horizontal timeline, reacts to the state of the timeline,
          /// and drives it's scroll position on Hz drag
          _Scrubber(_scroller, size: scrubberSize, timelineSize: minSize),
        ],
      );
    });
  }
}

class _Viewport extends StatefulWidget {
  const _Viewport({Key? key, this.controller, required this.minSize, required this.maxSize}) : super(key: key);
  final ScrollController? controller;
  final double minSize;
  final double maxSize;
  @override
  State<_Viewport> createState() => _ViewportState();
}

class _ViewportState extends State<_Viewport> {
  late final ScrollController _controller = ScrollController();

  double _zoom = .5;

  ScrollController get controller => widget.controller ?? ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeScale(double d) {
    setState(() {
      _zoom = d;
      _zoom = _zoom.clamp(0, 1.0);
    });
  }

  //
  // void _handleMouseZoom(e) {
  //   if (e is PointerScrollEvent) {
  //     final scaleDelta = .05 * (e.scrollDelta.dy > 0 ? -1 : 1);
  //     _changeScale(scaleDelta);
  //     //print(scaleDelta);
  //     // fix position
  //     final moveDelta = (_maxSize - _minSize) * scaleDelta;
  //     //_scroller.position.jumpTo(max(_scroller.position.pixels + moveDelta / 2, 0));
  //   }
  // }

  void _handlePinchZoom(ScaleUpdateDetails details) {
    _changeScale(details.scale);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double size = lerpDouble(widget.minSize, widget.maxSize, _zoom) ?? widget.maxSize;
      return GestureDetector(
        onScaleUpdate: _handlePinchZoom,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: controller,
              physics: ClampingScrollPhysics(),
              child: Placeholder(fallbackHeight: size),
            ),

            /// SB: Add a debug slider, so we can play with zoom easier on desktop
            _buildDebugScroller(context),
          ],
        ),
      );
    });
  }

  Center _buildDebugScroller(BuildContext context) {
    void handleZoomSliderChanged(double value) => setState(() {
          _zoom = value;
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          controller.notifyListeners();
        });
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.insets.lg * 2),
        child: SizedBox(
          height: max(60, context.heightPct(.1)),
          child: Slider(onChanged: handleZoomSliderChanged, value: _zoom, min: 0, max: 1),
        ),
      ),
    );
  }
}

class _Scrubber extends StatelessWidget {
  const _Scrubber(this.scroller, {Key? key, required this.timelineSize, required this.size}) : super(key: key);
  final ScrollController scroller;
  final double timelineSize;
  final double size;

  @override
  Widget build(BuildContext context) {
    void _handleScrubberPan(DragUpdateDetails details) {
      // TODO: This drag multiplier is close... but not exactly right.
      double dragMultiplier = (scroller.position.maxScrollExtent + timelineSize) / context.widthPx;
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
