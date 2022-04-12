import 'package:flutter/widgets.dart';

import '../fx.dart';
import 'abstract_fx.dart';

@immutable
class SlideFX extends AbstractFX<Offset> {
  const SlideFX({Duration? delay, Duration? duration, Curve? curve, Offset? begin, Offset? end}) :
    super(delay:delay, duration:duration, curve:curve, begin:begin ?? const Offset(0, -0.66), end:end ?? Offset.zero);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    return SlideTransition(
      position: buildAnimation(controller, entry),
      child: child,
    );
  }
}
extension SlideFXExtensions<T> on FXManager<T> {
  T slide({Duration? delay, Duration? duration, Curve? curve, Offset? begin, Offset? end}) =>
    addFX(SlideFX(delay: delay, duration: duration, curve: curve, begin:begin, end: end));
}