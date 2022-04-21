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

  ScrollController get controller => widget.controller ?? ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Allows ancestors to set zoom directly
  void setZoom(double d) {
    /// Determine which yr we're at now, zoom, and then snap to the correct yr position
    /// Current yr is ... complicated
    setState(() {
      _zoom = d;
      _zoom = _zoom.clamp(0, 1.0);
    });
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
    return LayoutBuilder(builder: (context, constraints) {
      double size = lerpDouble(widget.minSize, widget.maxSize, _zoom) ?? widget.maxSize;
      return LayoutBuilder(builder: (_, constraints) {
        return GestureDetector(
          onScaleUpdate: _handleScaleUpdate,
          onScaleStart: _handleScaleStart,
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: controller,
                padding: EdgeInsets.symmetric(vertical: constraints.maxHeight / 2),
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
    });
  }
}
