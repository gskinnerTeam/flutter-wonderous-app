import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TrackpadListener extends StatefulWidget {
  final Widget? child;
  final double scrollSensitivity;
  final ValueChanged<Offset>? onScroll;

  const TrackpadListener({
    super.key,
    this.child,
    this.scrollSensitivity = 100,
    this.onScroll,
  });

  @override
  State<TrackpadListener> createState() => _TrackpadListenerState();
}

class _TrackpadListenerState extends State<TrackpadListener> {
  Offset _scrollOffset = Offset.zero;

  void _handleTrackpadEvent(PointerSignalEvent event) {
    // Directly process the event here.
    if (event is PointerScrollEvent && event.kind == PointerDeviceKind.trackpad) {
      Offset newScroll = _scrollOffset + event.scrollDelta;
      newScroll = Offset(
        newScroll.dx.clamp(-widget.scrollSensitivity, widget.scrollSensitivity),
        newScroll.dy.clamp(-widget.scrollSensitivity, widget.scrollSensitivity),
      );
      _scrollOffset = newScroll;
      _update();
    }
  }

  void _update() {
    Offset directionScroll = Offset.zero;
    double sensitivity = widget.scrollSensitivity;
    if (_scrollOffset.dy >= sensitivity) {
      // Scroll down
      _scrollOffset += Offset(0.0, -sensitivity);
      directionScroll += Offset(0.0, -1.0);
    } else if (_scrollOffset.dy <= -sensitivity) {
      // Scroll up
      _scrollOffset += Offset(0.0, sensitivity);
      directionScroll += Offset(0.0, 1.0);
    }
    if (_scrollOffset.dx >= sensitivity) {
      // Scroll left
      _scrollOffset += Offset(-sensitivity, 0.0);
      directionScroll += Offset(-1.0, 0.0);
    } else if (_scrollOffset.dx <= -sensitivity) {
      // Scroll right
      _scrollOffset += Offset(sensitivity, 0.0);
      directionScroll += Offset(1.0, 0.0);
    }
    if (directionScroll != Offset.zero) {
      widget.onScroll?.call(directionScroll);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _handleTrackpadEvent,
      child: widget.child,
    );
  }
}
