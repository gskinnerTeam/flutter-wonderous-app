import 'package:flutter/widgets.dart';

import '../animate_effects.dart';

/// Effect that animates the opacity of the target (via [FadeTransition]) between the specified begin and end values.
/// It defaults to `begin=0, end=1`.
@immutable
class FadeEffect extends Effect<double> {
  const FadeEffect({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end})
      : super(delay: delay, duration: duration, curve: curve, begin: begin ?? 0.0, end: end ?? 1.0);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, EffectEntry entry) {
    return FadeTransition(
      opacity: buildAnimation(controller, entry),
      child: child,
    );
  }
}

extension FadeEffectExtensions<T> on AnimateManager<T> {
  /// Adds a `.fade()` extension to [AnimateManager] ([Animate] and [AnimateList]).
  T fade({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) =>
      addEffect(FadeEffect(delay: delay, duration: duration, curve: curve, begin: begin, end: end));

  
  /// Adds a `.fadeIn()` extension to [AnimateManager] ([Animate] and [AnimateList]).
  /// This is identical to the `.fade()` extension, but is included for semantic clarity.
  T fadeIn({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) =>
      addEffect(FadeEffect(delay: delay, duration: duration, curve: curve, begin: begin, end: end));

  /// Adds a `.fadeOut()` extension to [AnimateManager] ([Animate] and [AnimateList]).
  /// This is identical to the `.fade()` extension, except it defaults to `begin=1, end=0`.
  T fadeOut({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) =>
      addEffect(FadeEffect(delay: delay, duration: duration, curve: curve, begin: begin ?? 1.0, end: end ?? 0.0));
}
