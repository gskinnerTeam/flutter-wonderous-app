import 'dart:ui';

import 'package:wonders/common_libs.dart';

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
    double amt = sin(anim.value * pi) * 10;
    if (widget.enabled == false) amt = 0;
    double amtX = widget.dir.dx != 0 ? amt : 0;
    double amtY = widget.dir.dy != 0 ? amt : 0;
    // Scale back xBlur when moving diagonally for a better visual effect
    if (amtY != 0 && amtX != 0) {
      amtX *= .25;
      amtY *= .25;
    }
    final filter = ImageFilter.blur(sigmaX: amtX, sigmaY: amtY, tileMode: TileMode.decal);
    return ImageFiltered(imageFilter: filter, child: child);
  }
}
