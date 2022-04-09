import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../fx.dart';
import 'abstract_fx.dart';

@immutable
class BlurFX extends AbstractFX<double> {
  const BlurFX({delay, duration, curve, begin, end}) :
    super(delay:delay, duration:duration, curve:curve, begin:begin ?? 0.0, end:end ?? 4.0);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    Animation animation = buildAnimation(controller, entry);
    return AnimatedBuilder(animation: animation,
      builder: (BuildContext context, _) => ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: animation.value,
          sigmaY: animation.value,
          tileMode: TileMode.decal,
        ),
        child: child,
      )
    );
  }
}
extension BlurFXExtensions<T> on FXManager<T> {
  T blur({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) =>
    addFX(BlurFX(delay: delay, duration: duration, curve: curve, begin:begin, end: end));
}