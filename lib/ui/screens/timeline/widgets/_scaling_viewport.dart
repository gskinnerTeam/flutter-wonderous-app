part of '../timeline_screen.dart';

class _ScalingViewport extends StatefulWidget {
  const _ScalingViewport(
      {Key? key,
      this.controller,
      required this.minSize,
      required this.maxSize,
      required this.startYr,
      required this.endYr})
      : super(key: key);
  final ScrollController? controller;
  final double minSize;
  final double maxSize;
  final int startYr;
  final int endYr;

  @override
  State<_ScalingViewport> createState() => ScalingViewportState();
}

class ScalingViewportState extends State<_ScalingViewport> {
  late final ScrollController _controller = ScrollController();

  double _zoom = .5;
  double _zoomOnScaleStart = 0;

  late BoxConstraints _constraints;

  ScrollController get currentController => widget.controller ?? _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Allows ancestors to set zoom directly
  void setZoom(double d) {
    setState(() {
      /// Determine current yr, based on scroll position
      int totalYrs = widget.endYr - widget.startYr;
      double currentPx = currentController.position.pixels;
      double scrollAmt = currentPx / calculateContentHeight();
      double yr = widget.startYr + scrollAmt * totalYrs;

      /// Change zoom, which will scale our content, and change our scroll position
      _zoom = d;
      _zoom = _zoom.clamp(0, 1.0);

      jumpToYear(yr);
    });
  }

  void jumpToYear(double yr) {
    double yrRatio = (yr - widget.startYr) / (widget.endYr - widget.startYr);
    double newMaxScroll = calculateContentHeight();
    currentController.jumpTo(newMaxScroll * yrRatio);
  }

  double calculateContentHeight() {
    double vtPadding = _constraints.maxHeight / 2;
    return lerpDouble(max(widget.minSize - vtPadding, 300), widget.maxSize, _zoom) ?? widget.maxSize;
  }

  /// Since the onScale gesture always starts from 1, we need to hold onto the zoom
  /// value that we had when the scale gesture started and multiply it with the gesture data, to get the real new scale.
  void _handleScaleStart(ScaleStartDetails _) {
    _zoomOnScaleStart = _zoom;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setZoom(details.scale * _zoomOnScaleStart);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      _constraints = constraints; // cache constraints, so they can be used to maintain the selected year while zooming
      double vtPadding = constraints.maxHeight / 2;
      double size = calculateContentHeight();
      return GestureDetector(
        onScaleUpdate: _handleScaleUpdate,
        onScaleStart: _handleScaleStart,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              controller: currentController,
              padding: EdgeInsets.symmetric(vertical: vtPadding),
              child: SizedBox(
                height: size,
                child: Stack(
                  children: [
                    _YearMarkers(startYr: widget.startYr, endYr: widget.endYr),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
