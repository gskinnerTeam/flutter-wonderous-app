part of '../wonders_home_screen.dart';

/// A simple gradient with adjustable opacity,
class _SwipeableGradient extends StatelessWidget {
  const _SwipeableGradient(this.fgColor, {Key? key, required this.swipeController}) : super(key: key);
  final Color fgColor;
  final _VerticalSwipeController swipeController;
  @override
  Widget build(BuildContext context) {
    return swipeController.buildListener(builder: (swipeAmt, isPointerDown, _) {
      return IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                fgColor.withOpacity(0),
                fgColor.withOpacity(fgColor.opacity * .75 + (isPointerDown ? .05 : 0) + swipeAmt * .20),
              ],
              stops: const [0, 1],
            ),
          ),
        ),
      );
    });
  }
}
