part of '../collectible_found_screen.dart';

class _AnimatedRibbon extends StatelessWidget {
  const _AnimatedRibbon(this.text, {Key? key}) : super(key: key);

  final String text;
  static const double height = 48;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEnd(context, false),
            Spacer(),
            _buildEnd(context, true),
          ],
        ),
      ),
      Container(
        height: height,
        color: $styles.colors.accent1,
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
        margin: EdgeInsets.only(bottom: 10),
        // this aligns the text vertically, without expanding the container:
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(text, textAlign: TextAlign.center, style: $styles.text.title1)],
        ),
      ),
    ]);
  }

  Widget _buildEnd(BuildContext context, bool flip) {
    Widget end = Image.asset(ImagePaths.ribbonEnd, height: height);
    if (flip) end = Transform.scale(scaleX: -1, child: end);
    double m = flip ? 1 : -1;
    return end
        .animate()
        .move(begin: Offset(m * 8, 2), end: Offset(m * 32, 10), duration: 400.ms, curve: Curves.easeOut);
  }
}
