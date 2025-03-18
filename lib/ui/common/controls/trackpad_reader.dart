import 'package:flutter/gestures.dart';
import 'package:wonders/common_libs.dart';

class TrackpadReader extends StatefulWidget {
  static const int swipeSensitivity = 15;
  static const int scrollSensitivity = 100;

  const TrackpadReader({
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
  State<TrackpadReader> createState() => _TrackpadReaderState();
}

class _TrackpadReaderState extends State<TrackpadReader> {
  void _handleTrackpadEvent(PointerSignalEvent event) {
    GestureBinding.instance.pointerSignalResolver.register(event, (PointerSignalEvent event) {
      if (event is PointerScrollEvent && event.kind == PointerDeviceKind.trackpad) {
        debugPrint(' - TrackpadReader: ${event}');
        debugPrint(' - TrackpadReader A: ${event.scrollDelta}');
        debugPrint(' - TrackpadReader B: ${event.platformData}');
        debugPrint(' - TrackpadReader C: ${event.buttons}');
        debugPrint(' - TrackpadReader D: ${event.delta}');
        debugPrint(' - TrackpadReader E: ${event.device}');
        debugPrint(' - TrackpadReader F: ${event.kind}');
        debugPrint(' - TrackpadReader G: ${event.timeStamp}');
        debugPrint(' - TrackpadReader H: ${event.size}');
        if (event.scrollDelta.dy > TrackpadReader.swipeSensitivity) {
          widget.swipeUp?.call();
        } else if (event.scrollDelta.dy < TrackpadReader.swipeSensitivity) {
          widget.swipeDown?.call();
        }
        if (event.scrollDelta.dx > TrackpadReader.swipeSensitivity) {
          widget.swipeLeft?.call();
        } else if (event.scrollDelta.dx < TrackpadReader.swipeSensitivity) {
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
