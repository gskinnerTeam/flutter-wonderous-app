import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wonders/common_libs.dart';

class AppPageIndicator extends StatelessWidget {
  const AppPageIndicator(
      {Key? key, required this.count, required this.controller, this.onDotPressed, this.color, this.dotSize})
      : super(key: key);
  final int count;
  final PageController controller;
  final void Function(int index)? onDotPressed;
  final Color? color;
  final double? dotSize;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_declarations
    final s = "d";
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      onDotClicked: onDotPressed,
      effect: ExpandingDotsEffect(
          dotWidth: dotSize ?? 4,
          dotHeight: dotSize ?? 4,
          paintStyle: PaintingStyle.fill,
          strokeWidth: (dotSize ?? 4) / 2,
          dotColor: color ?? context.colors.accent1,
          activeDotColor: color ?? context.colors.accent1,
          expansionFactor: 2),
    );
  }
}