import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/directional_blur.dart';

class MotionBlur extends StatefulWidget {
  const MotionBlur(this.duration,
      {Key? key, required this.child, required this.dir, this.animationKey, this.enabled = true})
      : super(key: key);
  final Widget child;
  final Duration duration;
  final Offset dir;
  final Key? animationKey;
  final bool enabled;
  @override
  State<MotionBlur> createState() => _MotionBlurState();
}

class _MotionBlurState extends State<MotionBlur> {
  GTweenerController? _blur;

  @override
  void didUpdateWidget(covariant MotionBlur oldWidget) {
    if (oldWidget.animationKey != widget.animationKey) {
      _blur?.animation.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GTweener(
      [GCustom(builder: _buildBlur)],
      onInit: (t) => _blur = t,
      duration: widget.duration,
      curve: Curves.easeOut,
      child: widget.child,
    );
  }

  Widget _buildBlur(Widget child, Animation<double> anim) {
    double amt = sin(anim.value * pi) * 15;
    if (widget.enabled == false) amt = 0;
    final angle = atan2(widget.dir.dy, widget.dir.dx);
    if (angle.abs() != pi * .25) {
      amt = 0;
    }
    return DirectionalBlur(blurAmount: amt, angle: -angle, child: child);
  }
}
