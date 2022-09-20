part of 'wonders_home_screen.dart';

class _VerticalSwipeController {
  _VerticalSwipeController(this.ticker, this.onSwipeComplete);
  final TickerProvider ticker;
  final swipeAmt = ValueNotifier<double>(0);
  final isPointerDown = ValueNotifier<bool>(false);
  late final swipeReleaseAnim = AnimationController(vsync: ticker)..addListener(handleSwipeReleaseAnimTick);
  final double _pullToViewDetailsThreshold = 150;
  final VoidCallback onSwipeComplete;

  /// When the _swipeReleaseAnim plays, sync its value to _swipeUpAmt
  void handleSwipeReleaseAnimTick() => swipeAmt.value = swipeReleaseAnim.value;
  void handleTapDown() => isPointerDown.value = true;
  void handleTapCancelled() => isPointerDown.value = false;

  void handleVerticalSwipeCancelled() {
    swipeReleaseAnim.duration = swipeAmt.value.seconds * .5;
    swipeReleaseAnim.reverse(from: swipeAmt.value);
    isPointerDown.value = false;
  }

  void handleVerticalSwipeUpdate(DragUpdateDetails details) {
    if (swipeReleaseAnim.isAnimating) swipeReleaseAnim.stop();
    if (details.delta.dy > 0) {
      swipeAmt.value = 0;
    } else {
      isPointerDown.value = true;
      double value = (swipeAmt.value - details.delta.dy / _pullToViewDetailsThreshold).clamp(0, 1);
      if (value != swipeAmt.value) {
        swipeAmt.value = value;
        if (swipeAmt.value == 1) {
          onSwipeComplete();
        }
      }
    }
    //print(_swipeUpAmt.value);
  }

  /// Utility method to wrap a couple of ValueListenableBuilders and pass the values into a builder methods.
  /// Saves the UI some boilerplate when subscribing to changes.
  Widget buildListener(
      {required Widget Function(double swipeUpAmt, bool isPointerDown, Widget? child) builder, Widget? child}) {
    return ValueListenableBuilder<double>(
      valueListenable: swipeAmt,
      builder: (_, swipeAmt, __) => ValueListenableBuilder<bool>(
        valueListenable: isPointerDown,
        builder: (_, isPointerDown, __) {
          return builder(swipeAmt, isPointerDown, child);
        },
      ),
    );
  }

  /// Utility method to wrap a gesture detector and wire up the required handlers.
  Widget wrapGestureDetector(Widget child, {Key? key}) => GestureDetector(
      key: key,
      excludeFromSemantics: true,
      onTapDown: (_) => handleTapDown(),
      onTapUp: (_) => handleTapCancelled(),
      onVerticalDragUpdate: handleVerticalSwipeUpdate,
      onVerticalDragEnd: (_) => handleVerticalSwipeCancelled(),
      onVerticalDragCancel: handleVerticalSwipeCancelled,
      behavior: HitTestBehavior.translucent,
      child: child);
}
