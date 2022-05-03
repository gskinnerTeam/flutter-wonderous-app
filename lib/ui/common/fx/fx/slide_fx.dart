import 'package:flutter/widgets.dart';

import '../fx.dart';

/// Effect that moves the target based on a fraction of its size (via `SlideTransition`)
/// based on the specified begin and end offsets. Defaults to `begin=Offset(0, -0.5),
/// end=Offset.zero` (ie. slide down from half its height).
@immutable
class SlideFX extends AbstractFX<Offset> {
  const SlideFX({Duration? delay, Duration? duration, Curve? curve, Offset? begin, Offset? end})
      : super(
            delay: delay,
            duration: duration,
            curve: curve,
            begin: begin ?? const Offset(0, -0.5),
            end: end ?? Offset.zero);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    return SlideTransition(
      position: buildAnimation(controller, entry),
      child: child,
    );
  }
}

extension SlideFXExtensions<T> on FXManager<T> {
  /// Adds a `.slide()` extension to [FXManager] ([FXAnimate] and [FXAnimateList]).
  T slide({Duration? delay, Duration? duration, Curve? curve, Offset? begin, Offset? end}) =>
      addFX(SlideFX(delay: delay, duration: duration, curve: curve, begin: begin, end: end));
}
