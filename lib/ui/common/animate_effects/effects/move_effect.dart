import 'package:flutter/widgets.dart';

import '../animate_effects.dart';

// TODO: GDS: possibly add transformHitTest as a param?

/// Effect that moves the target (via [Transform.translate]) between the specified begin and end offsets.
/// Defaults to `begin=Offset(0, -16), end=Offset.zero`.
@immutable
class MoveEffect extends Effect<Offset> {
  const MoveEffect({Duration? delay, Duration? duration, Curve? curve, Offset? begin, Offset? end})
      : super(
            delay: delay,
            duration: duration,
            curve: curve,
            begin: begin ?? const Offset(0, -16),
            end: end ?? Offset.zero);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, EffectEntry entry) {
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

extension MoveEffectExtensions<T> on AnimateManager<T> {
  /// Adds a `.move()` extension to [AnimateManager] ([Animate] and [AnimateList]).
  T move({Duration? delay, Duration? duration, Curve? curve, Offset? begin, Offset? end}) =>
      addEffect(MoveEffect(delay: delay, duration: duration, curve: curve, begin: begin, end: end));
}
