import 'package:flutter/gestures.dart';
import 'package:wonders/common_libs.dart';

class TrackpadListener extends StatefulWidget {
  static const int swipeSensitivity = 15;
  static const int scrollSensitivity = 100;

  const TrackpadListener({
    super.key,
    required this.child,
    this.swipeUp,
    this.swipeDown,
    this.swipeLeft,
    this.swipeRight,
    this.scrollUp,
    this.scrollDown,
    this.scrollLeft,
    this.scrollRight,
  });

  final Widget child;
  final void Function()? swipeUp;
  final void Function()? swipeDown;
  final void Function()? swipeLeft;
  final void Function()? swipeRight;
  final void Function()? scrollUp;
  final void Function()? scrollDown;
  final void Function()? scrollLeft;
  final void Function()? scrollRight;

  @override
  State<TrackpadListener> createState() => _TrackpadListenerState();
}

class _TrackpadListenerState extends State<TrackpadListener> {
  void _handleTrackpadEvent(PointerSignalEvent event) {
    GestureBinding.instance.pointerSignalResolver.register(event, (PointerSignalEvent event) {
      if (event is PointerScrollEvent && event.kind == PointerDeviceKind.trackpad) {
        if (event.scrollDelta.dy > TrackpadListener.swipeSensitivity) {
          widget.swipeDown?.call();
        } else if (event.scrollDelta.dy < -TrackpadListener.swipeSensitivity) {
          widget.swipeUp?.call();
        }
        if (event.scrollDelta.dx > TrackpadListener.swipeSensitivity) {
          widget.swipeLeft?.call();
        } else if (event.scrollDelta.dx < -TrackpadListener.swipeSensitivity) {
          widget.swipeRight?.call();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerPanZoomStart: (event) {
          debugPrint(' - TrackpadReader: onPointerPanZoomStart');
        },
        onPointerPanZoomEnd: (event) {
          debugPrint(' - TrackpadReader: onPointerPanZoomEnd');
        },
        onPointerSignal: _handleTrackpadEvent,
        child: widget.child);
  }
}
