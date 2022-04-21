part of '../timeline_screen.dart';

class _DashedDividerWithYear extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox(
        height: 2,
        width: double.infinity,
        child: CustomPaint(painter: _DashedLinePainter()),
      );
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double width = 3, gap = 3, xPos = 0;
    final paint = Paint()..color = Colors.white;
    while (xPos < size.width) {
      canvas.drawLine(Offset(xPos, 0), Offset(xPos + width, 0), paint);
      xPos += width + gap;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
