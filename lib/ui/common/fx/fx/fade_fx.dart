import 'package:flutter/widgets.dart';

import '../fx.dart';

/// Effect that animates the opacity of the target between the specified begin and end values.
/// It defaults to `begin=0, end=1`.
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
  /// Adds a `.fade()` extension to [FXManager] ([FXAnimate] and [FXAnimateList]).
  T fade({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) =>
      addFX(FadeFX(delay: delay, duration: duration, curve: curve, begin: begin, end: end));
  /// Adds a `.fadeOut()` extension to [FXManager] ([FXAnimate] and [FXAnimateList]). This behaves
  /// identically to the `.fade()` extension, except it defaults to `begin=1, end=0`.
  T fadeOut({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) =>
      addFX(FadeFX(delay: delay, duration: duration, curve: curve, begin: begin ?? 1.0, end: end ?? 0.0));
}
