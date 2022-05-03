import 'package:flutter/scheduler.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/directional_blur.dart';

class AnimatedMotionBlur extends StatefulWidget {
  const AnimatedMotionBlur(this.duration,
      {Key? key, required this.child, required this.dir, this.animationKey, this.enabled = true, this.blurStrength = 5})
      : super(key: key);
  final Widget child;
  final Duration duration;
  final Offset dir;
  final Key? animationKey;
  final bool enabled;
  final double blurStrength;
  @override
  State<AnimatedMotionBlur> createState() => _AnimatedMotionBlurState();
}

class _AnimatedMotionBlurState extends State<AnimatedMotionBlur> {
  AnimationController? _blur;

  @override
  void didUpdateWidget(covariant AnimatedMotionBlur oldWidget) {
    if (oldWidget.animationKey != widget.animationKey) {
      _blur?.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return FXAnimate(
      fx: [CustomFX(_buildBlur, duration: widget.duration, curve: Curves.easeOut)],
      onInit: (t) => _blur = t,
      child: widget.child,
    );
  }

  Widget _buildBlur(BuildContext context, double anim, Widget child) {
    double amt = sin(anim * pi) * 5;
    if (widget.enabled == false) amt = 0;
    final rads = atan2(widget.dir.dy, widget.dir.dx);
    return DirectionalBlur(blurAmount: amt, rotation: -rads, child: child);
  }
}
