import 'package:flutter/widgets.dart';
import 'package:wonders/ui/common/fx/fx.dart';

@immutable
class FadeFX extends AbstractFX<double> {
  const FadeFX({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end})
      : super(delay: delay, duration: duration, curve: curve, begin: begin ?? 0.0, end: end ?? 1.0);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    return FadeTransition(
      opacity: buildAnimation(controller, entry),
      child: child,
    );
  }
}

extension FadeFXExtensions<T> on FXManager<T> {
  T fade({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) =>
      addFX(FadeFX(delay: delay, duration: duration, curve: curve, begin: begin, end: end));
  T fadeOut({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) =>
      addFX(FadeFX(delay: delay, duration: duration, curve: curve, begin: begin ?? 1.0, end: end ?? 0.0));
}
