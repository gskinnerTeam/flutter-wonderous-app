import 'package:flutter/widgets.dart';

import '../fx.dart';

/// Effect that scales the target between the specified begin and end values.
/// Defaults to `begin=0, end=1`.
@immutable
class ScaleFX extends AbstractFX<double> {
  const ScaleFX({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end, this.alignment})
      : super(delay: delay, duration: duration, curve: curve, begin: begin ?? 0.0, end: end ?? 1.0);

  final Alignment? alignment;

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    return ScaleTransition(
      alignment: alignment ?? Alignment.center,
      scale: buildAnimation(controller, entry),
      child: child,
    );
  }
}

extension ScaleFXExtensions<T> on FXManager<T> {
  /// Adds a `.scale()` extension to [FXManager] ([FXAnimate] and [FXAnimateList]).
  T scale({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end, Alignment? alignment}) =>
      addFX(ScaleFX(delay: delay, duration: duration, curve: curve, begin: begin, end: end, alignment: alignment));
}
