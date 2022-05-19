import 'package:flutter/widgets.dart';

import '../animate_effects.dart';

/// Effect that scales the target (via [ScaleTransition]) between the specified begin and end values.
/// Defaults to `begin=0, end=1`.
@immutable
class ScaleEffect extends Effect<double> {
  const ScaleEffect({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end, this.alignment})
      : super(delay: delay, duration: duration, curve: curve, begin: begin ?? 0.0, end: end ?? 1.0);

  final Alignment? alignment;

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, EffectEntry entry) {
    return ScaleTransition(
      alignment: alignment ?? Alignment.center,
      scale: buildAnimation(controller, entry),
      child: child,
    );
  }
}

extension ScaleEffectExtensions<T> on AnimateManager<T> {
  /// Adds a `.scale()` extension to [AnimateManager] ([Animate] and [AnimateList]).
  T scale({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end, Alignment? alignment}) =>
      addEffect(ScaleEffect(delay: delay, duration: duration, curve: curve, begin: begin, end: end, alignment: alignment));
}
