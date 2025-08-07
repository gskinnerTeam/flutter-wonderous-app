import 'package:wonders/common_libs.dart';

/// Colored box that can fade in and out, should yield better performance than
/// fading with an additional Opacity layer.
class FadeColorTransition extends StatelessWidget {
  const FadeColorTransition({super.key, required this.animation, required this.color});
  final Animation<double> animation;
  final Color color;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: animation,
    builder: (context, child) => Container(color: color.withValues(alpha: animation.value)),
  );
}
