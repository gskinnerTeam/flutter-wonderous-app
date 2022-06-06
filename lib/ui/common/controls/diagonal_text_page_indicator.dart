import 'package:wonders/common_libs.dart';

class DiagonalTextPageIndicator extends StatelessWidget {
  const DiagonalTextPageIndicator({Key? key, required this.current, required this.total}) : super(key: key);
  final int current;
  final int total;
  static const double _fontSize = 32;

  @override
  Widget build(BuildContext context) {
    //final textShadows = [Shadow(color: Colors.black.withOpacity(.5), offset: Offset(0, 4), blurRadius: 6)];
    final textStyle = $styles.text.titleFont.copyWith(fontSize: _fontSize, height: 1);
    const size = _fontSize * 1.5;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: textStyle.fontSize! * .4).copyWith(top: textStyle.fontSize! * .2),
      child: Stack(children: [
        ClipPath(
          clipper: _DiagonalClipper(leftSide: true),
          child: Transform.translate(
            offset: Offset(-_fontSize * .7, 0),
            child: SizedBox(
                width: size,
                height: size,
                child: Text('0$current',
                    style: textStyle.copyWith(shadows: $styles.shadows.text), textAlign: TextAlign.right)),
          ),
        ),
        ClipPath(
          clipper: _DiagonalClipper(leftSide: false),
          child: Transform.translate(
            offset: Offset(_fontSize * .45, _fontSize * .6),
            child: SizedBox(
              width: size,
              height: size,
              child: Opacity(
                opacity: .5,
                child: Text(
                  '0$total',
                  style: textStyle.copyWith(shadows: $styles.shadows.textStrong),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Transform.rotate(
              angle: pi * -.25,
              child: Container(height: 2, color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}

class _DiagonalClipper extends CustomClipper<Path> {
  _DiagonalClipper({required this.leftSide});
  final bool leftSide;

  @override
  Path getClip(Size size) {
    const double lineGap = 2;
    if (leftSide) {
      return Path()
        ..lineTo(size.width - lineGap, 0)
        ..lineTo(-lineGap, size.height)
        ..lineTo(-lineGap, 0)
        ..addRect(Rect.fromLTRB(-size.width * .5, 0, 0, size.height))
        ..addRect(Rect.fromLTRB(-size.width * .5, -size.height * .5, size.width, 0));
    }
    return Path()
      ..moveTo(size.width + lineGap, 0)
      ..lineTo(size.width, size.height + lineGap)
      ..lineTo(lineGap, size.height + lineGap)
      ..lineTo(size.width + lineGap, 0)
      ..addRect(Rect.fromLTRB(size.width, 0, size.width * 1.5, size.height * 1.5));
  }

  @override
  bool shouldReclip(covariant Object oldClipper) => true;
}
