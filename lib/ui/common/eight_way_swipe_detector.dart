import 'package:wonders/common_libs.dart';

class EightWaySwipeDetector extends StatelessWidget {
  const EightWaySwipeDetector({Key? key, required this.child, required this.onSwipe}) : super(key: key);
  final Widget child;
  final void Function(Offset dir)? onSwipe;

  @override
  Widget build(BuildContext context) {
    Offset _startPos = Offset.zero;
    Offset _endPos = Offset.zero;
    return StatefulBuilder(
      builder: (_, __) {
        return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanStart: (d) => _startPos = d.localPosition,
            onPanUpdate: (d) => _endPos = d.localPosition,
            onPanEnd: (d) {
              // Calculate a degree for the swipe, from 0 - 360
              double dx = _endPos.dx - _startPos.dx;
              double dy = _endPos.dy - _startPos.dy;
              if ((dx.abs() + dy.abs()) < 20) return; // ignore very small swipes
              // Get the angle of the line between start and end position
              final rads = atan2(dy, dx);
              // Convert rads to degrees, (0 to 360)
              final degrees = (rads * 180 / pi + 180);
              // Using the angle, get a direction
              Offset dir = _calculateDirection(degrees);
              onSwipe?.call(dir);
            },
            child: child);
      },
    );
  }

  Offset _calculateDirection(double degrees) {
    final offsets = [
      Offset(-1, -1), // left-up
      Offset(0, -1), // up
      Offset(1, -1), // right-up
      Offset(1, 0), // right
      Offset(1, 1), // right-down
      Offset(0, 1), // down
      Offset(-1, 1), // left-down
    ];
    // Loop through 7 segments and see if the angle matches any of them.
    // Start at 22.5 degrees and add 45 degrees each step
    double angle = 45 / 2;
    for (var i = 0; i < 7; i++) {
      if (degrees > angle && degrees < angle + 45) return offsets[i];
      angle += 45;
    }
    // If nothing matches, the 8th segment must match, which is left (degrees 0 - 22.5 and 337.5 - 360)
    return Offset(-1, 0);
  }
}
