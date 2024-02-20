import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/static_text_scale.dart';

class DiagonalTextPageIndicator extends StatelessWidget {
  const DiagonalTextPageIndicator({super.key, required this.current, required this.total});
  final int current;
  final int total;
  static final _fontSize = 26 * $styles.scale;

  @override
  Widget build(BuildContext context) {
    final textStyle = $styles.text.titleFont.copyWith(fontSize: _fontSize, height: 1);
    final size = _fontSize * 1.5;
    return StaticTextScale(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: textStyle.fontSize! * .4).copyWith(top: textStyle.fontSize! * .2),
        child: Stack(children: [
          ClipPath(
            clipper: _DiagonalClipper(leftSide: true),
            child: Transform.translate(
              offset: Offset(-_fontSize * .7, 0),
              child: SizedBox(
                  width: size, height: size, child: Text('0$current', style: textStyle, textAlign: TextAlign.right)),
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
                    style: textStyle, //.copyWith(shadows: $styles.shadows.textStrong),
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
      ),
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
