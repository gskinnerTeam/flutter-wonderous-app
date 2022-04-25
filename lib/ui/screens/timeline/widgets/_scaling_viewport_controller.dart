part of '../timeline_screen.dart';

class _ScalingViewportController extends ChangeNotifier {
  _ScalingViewportController(this.state);
  final ScalingViewportState state;
  double _zoom = .5;
  double _zoomOnScaleStart = 0;
  late BoxConstraints _constraints;
  _ScalingViewport get widget => state.widget;
  ScrollController get scroller => widget.scroller;

  /// Allows ancestors to set zoom directly
  void setZoom(double d) {
    // ignore: invalid_use_of_protected_member
    state.setState(() {
      // Determine current yr, based on scroll position
      int currentYr = calculateYearFromScrollPos();

      // Change zoom, which will scale our content, and change our scroll position
      _zoom = d;
      _zoom = _zoom.clamp(0, 1.0);

      // Jump to whatever yr we were on before changing the zoom
      jumpToYear(currentYr);
    });
  }

  /// Jump to the scroll position for a given yr. Does not animated.
  void jumpToYear(int yr, {bool animate = false}) {
    double yrRatio = (yr - widget.startYr) / (widget.endYr - widget.startYr);
    double newMaxScroll = calculateContentHeight();
    final newPos = newMaxScroll * yrRatio;
    if (animate) {
      scroller.animateTo(newPos, duration: state.context.times.med, curve: Curves.easeOut);
    } else {
      scroller.jumpTo(newPos);
    }
  }

  /// Calculates current content height, taking zoom into account.
  double calculateContentHeight() {
    //double minSize = 300;
    double vtPadding = _constraints.maxHeight / 2;
    return lerpDouble(widget.minSize - vtPadding, widget.maxSize, _zoom) ?? widget.maxSize;
  }

  /// Derive current yr based on the scroll position and the current content height.
  int calculateYearFromScrollPos() {
    if (scroller.hasClients == false) return widget.startYr;
    int totalYrs = widget.endYr - widget.startYr;
    double currentPx = scroller.position.pixels;
    double scrollAmt = currentPx / calculateContentHeight();
    int result = (widget.startYr + scrollAmt * totalYrs).round();
    return result.clamp(widget.startYr, widget.endYr);
  }

  /// Since the onScale gesture always starts from 1, we need to hold onto the zoom
  /// value that we had when the scale gesture started and multiply it with the gesture data, to get the real new scale.
  void _handleScaleStart(ScaleStartDetails _) => _zoomOnScaleStart = _zoom;

  void _handleScaleUpdate(ScaleUpdateDetails details) => setZoom(details.scale * _zoomOnScaleStart);
}
