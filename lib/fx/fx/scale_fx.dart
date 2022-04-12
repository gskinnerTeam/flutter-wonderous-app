import 'package:flutter/widgets.dart';

import '../fx.dart';
import 'abstract_fx.dart';

@immutable
class ScaleFX extends AbstractFX<double> {
  const ScaleFX({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) :
    super(delay:delay, duration:duration, curve:curve, begin:begin ?? 0.0, end:end ?? 1.0);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    return ScaleTransition(
      scale: buildAnimation(controller, entry),
      child: child,
    );
  }
}
extension ScaleFXExtensions<T> on FXManager<T> {
  T scale({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) =>
    addFX(ScaleFX(delay: delay, duration: duration, curve: curve, begin:begin, end: end));
}