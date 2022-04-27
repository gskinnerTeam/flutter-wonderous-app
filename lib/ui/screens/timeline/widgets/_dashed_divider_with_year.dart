part of '../timeline_screen.dart';

class _DashedDividerWithYear extends StatelessWidget {
  const _DashedDividerWithYear(this.year, {Key? key}) : super(key: key);
  final int year;

  @override
  Widget build(BuildContext context) {
    int yrGap = 10;
    final roundedYr = (year / yrGap).round() * yrGap;
    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: 2,
            width: double.infinity,
            child: CustomPaint(painter: _DashedLinePainter()),
          ),
        ),
        CenterRight(
          child: FractionalTranslation(
            translation: Offset(0, -.5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$roundedYr', style: context.text.h2.copyWith(color: context.colors.white)),
                Gap(context.insets.xs),
                Text(StringUtils.getYrSuffix(roundedYr), style: context.text.body.copyWith(color: Colors.white)),
              ],
            ),
          ),
        )
      ],
    );
  }
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
