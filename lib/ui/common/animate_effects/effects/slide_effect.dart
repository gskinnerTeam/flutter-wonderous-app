import 'package:flutter/widgets.dart';

import '../animate_effects.dart';

/// Effect that moves the target based on a fraction of its size (via [SlideTransition])
/// based on the specified begin and end offsets. Defaults to `begin=Offset(0, -0.5),
/// end=Offset.zero` (ie. slide down from half its height).
@immutable
class SlideEffect extends Effect<Offset> {
  const SlideEffect({Duration? delay, Duration? duration, Curve? curve, Offset? begin, Offset? end})
      : super(
            delay: delay,
            duration: duration,
            curve: curve,
            begin: begin ?? const Offset(0, -0.5),
            end: end ?? Offset.zero);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, EffectEntry entry) {
    return SlideTransition(
      position: buildAnimation(controller, entry),
      child: child,
    );
  }
}

extension SlideEffectExtensions<T> on AnimateManager<T> {
  /// Adds a `.slide()` extension to [AnimateManager] ([Animate] and [AnimateList]).
  T slide({Duration? delay, Duration? duration, Curve? curve, Offset? begin, Offset? end}) =>
      addEffect(SlideEffect(delay: delay, duration: duration, curve: curve, begin: begin, end: end));
}
