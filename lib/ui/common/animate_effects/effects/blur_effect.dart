import 'dart:ui';
import 'package:flutter/widgets.dart';

import '../animate_effects.dart';

/// Effect that animates a blur on the target between the specified begin and end values.
/// Defaults to a blur radius of `begin=0, end=4`.
@immutable
class BlurEffect extends Effect<double> {
  const BlurEffect({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end})
      : super(delay: delay, duration: duration, curve: curve, begin: begin ?? 0.0, end: end ?? 4.0);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, EffectEntry entry) {
    Animation animation = buildAnimation(controller, entry);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: animation.value,
          sigmaY: animation.value,
          tileMode: TileMode.decal,
        ),
        child: child,
      ),
    );
  }
}

extension BlurEffectExtensions<T> on AnimateManager<T> {
  /// Adds a `.blur()` extension to [AnimateManager] ([Animate] and [AnimateList]).
  T blur({Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) =>
      addEffect(BlurEffect(delay: delay, duration: duration, curve: curve, begin: begin, end: end));
}
