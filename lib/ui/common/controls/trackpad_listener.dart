import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:wonders/common_libs.dart';

class TrackpadListener extends StatefulWidget {
  final Widget child;
  final double scrollSensitivity;
  final void Function()? onScrollUp;
  final void Function()? onScrollDown;
  final void Function()? onScrollLeft;
  final void Function()? onScrollRight;
  final void Function(Offset delta)? onScroll;

  const TrackpadListener({
    super.key,
    required this.child,
    this.scrollSensitivity = 100,
    this.onScrollUp,
    this.onScrollDown,
    this.onScrollLeft,
    this.onScrollRight,
    this.onScroll,
  });

  @override
  State<TrackpadListener> createState() => _TrackpadListenerState();
}

class _TrackpadListenerState extends State<TrackpadListener> {
  Offset _scrollOffset = Offset.zero;
  void _handleTrackpadEvent(PointerSignalEvent event) {
    GestureBinding.instance.pointerSignalResolver.register(event, (PointerSignalEvent event) {
      if (event is PointerScrollEvent && event.kind == PointerDeviceKind.trackpad) {
        Offset newScroll = _scrollOffset + event.scrollDelta;
        newScroll = Offset(
          newScroll.dx.clamp(-widget.scrollSensitivity, widget.scrollSensitivity),
          newScroll.dy.clamp(-widget.scrollSensitivity, widget.scrollSensitivity),
        );
        _update(newScroll);
      }
    });
  }

  void _update(Offset newOffset) {
    Offset directionScroll = Offset.zero;
    double sensitivity = widget.scrollSensitivity;
    while (newOffset.dy >= sensitivity) {
      widget.onScrollDown?.call();
      newOffset -= Offset(0.0, sensitivity);
      directionScroll -= Offset(0.0, 1.0);
    }
    while (newOffset.dy <= -sensitivity) {
      widget.onScrollUp?.call();
      newOffset += Offset(0.0, sensitivity);
      directionScroll += Offset(0.0, 1.0);
    }
    while (newOffset.dx >= sensitivity) {
      widget.onScrollLeft?.call();
      newOffset -= Offset(sensitivity, 0.0);
      directionScroll -= Offset(1.0, 0.0);
    }
    while (newOffset.dx <= -sensitivity) {
      widget.onScrollRight?.call();
      newOffset += Offset(sensitivity, 0.0);
      directionScroll += Offset(1.0, 0.0);
    }
    if (directionScroll != Offset.zero) {
      widget.onScroll?.call(directionScroll);
    }
    // Tone it down over time.
    newOffset *= 0.9;
    setState(() => _scrollOffset = newOffset);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _handleTrackpadEvent,
      child: widget.child,
    );
  }
}
