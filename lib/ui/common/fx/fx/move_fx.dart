import 'package:flutter/widgets.dart';

import '../fx.dart';

/// Effect that moves the target (via `Transform.translate`) between the specified begin and end offsets.
/// Defaults to `begin=Offset(0, -16), end=Offset.zero`.
@immutable
class MoveFX extends AbstractFX<Offset> {
  const MoveFX({Duration? delay, Duration? duration, Curve? curve, Offset? begin, Offset? end})
      : super(
            delay: delay,
            duration: duration,
            curve: curve,
            begin: begin ?? const Offset(0, -16),
            end: end ?? Offset.zero);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    Animation<Offset> animation = buildAnimation(controller, entry);
    return AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (ctx, child) {
          Offset offset = animation.value;
          return Transform.translate(offset: offset, child: child);
        });
  }
}

extension MoveFXExtensions<T> on FXManager<T> {
  /// Adds a `.move()` extension to [FXManager] ([FXAnimate] and [FXAnimateList]).
  T move({Duration? delay, Duration? duration, Curve? curve, Offset? begin, Offset? end}) =>
      addFX(MoveFX(delay: delay, duration: duration, curve: curve, begin: begin, end: end));
}
