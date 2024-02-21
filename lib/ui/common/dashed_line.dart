import 'package:wonders/common_libs.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({super.key, this.vertical = false});
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: vertical ? 2 : double.infinity,
      height: vertical ? double.infinity : 2,
      child: CustomPaint(painter: _DashedLinePainter(vertical)),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter(this.vertical);
  final bool vertical;

  @override
  void paint(Canvas canvas, Size size) {
    double dashPx = 3, gapPx = 3, pos = 0;
    final paint = Paint()..color = Colors.white;
    if (vertical) {
      while (pos < size.height) {
        canvas.drawLine(Offset(0, pos), Offset(0, pos + dashPx), paint);
        pos += dashPx + gapPx;
      }
    } else {
      while (pos < size.width) {
        canvas.drawLine(Offset(pos, 0), Offset(pos + dashPx, 0), paint);
        pos += dashPx + gapPx;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
