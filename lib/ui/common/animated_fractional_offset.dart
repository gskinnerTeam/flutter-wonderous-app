import 'package:wonders/common_libs.dart';

class AnimatedFractionalOffset extends StatelessWidget {
  const AnimatedFractionalOffset({
    Key? key,
    required this.offset,
    required this.child,
    required this.duration,
    required this.curve,
  }) : super(key: key);
  final Offset offset;
  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      duration: context.times.fast,
      curve: Curves.easeOut,
      tween: Tween(begin: offset, end: offset),
      builder: (_, value, __) => FractionalTranslation(translation: value, child: child),
    );
  }
}
