import 'dart:ui';

import 'package:gtween/gtween.dart';
import 'package:wonders/common_libs.dart';

class MotionBlurController {
  MotionBlurController(this._state);
  final _MotionBlurState _state;

  void restart() => _state._tween?.animation.forward(from: 0);
}

class MotionBlur extends StatefulWidget {
  const MotionBlur(this.duration, {Key? key, required this.child, required this.dir, this.onInit}) : super(key: key);
  final Widget child;
  final Duration duration;
  final Offset dir;
  final void Function(MotionBlurController controller)? onInit;

  @override
  State<MotionBlur> createState() => _MotionBlurState();
}

class _MotionBlurState extends State<MotionBlur> {
  GTweenerController? _tween;
  late MotionBlurController controller = MotionBlurController(this);
  @override
  void initState() {
    super.initState();
    widget.onInit?.call(controller);
  }

  @override
  Widget build(BuildContext context) {
    return GTweener(
      [GCustom(builder: _buildBlur)],
      onInit: (t) => _tween = t,
      duration: widget.duration,
      child: widget.child,
    );
  }

  Widget _buildBlur(Widget child, Animation<double> anim) {
    double amt = sin(anim.value * pi) * 15;
    if (widget.dir.dx != 0 && widget.dir.dy != 0) {
      amt *= .3; // When moving diagonally, lessen the amt for a better effect
    }
    final filter = ImageFilter.blur(
      sigmaX: widget.dir.dx != 0 ? amt : 0,
      sigmaY: widget.dir.dy != 0 ? amt : 0,
      tileMode: TileMode.decal,
    );
    return ImageFiltered(imageFilter: filter, child: child);
  }
}
