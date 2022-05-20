import 'package:flutter/widgets.dart';

import 'effects/effects.dart';
import 'animate.dart';
import 'animate_list.dart';

export 'animate.dart';
export 'animate_list.dart';
export 'effects/effects.dart';
export 'num_duration_extensions.dart';

/// Because [Effect] classes are immutable and may be reused between multiple
/// [Animate] (or [AnimateList]) instances, an `EffectEntry` is created to store
/// values that may be different between instances. For example, due to
/// `interval` offsets, or from inheriting values from prior effects in the chain.
@immutable
class EffectEntry {
  const EffectEntry({
    required this.effect,
    required this.begin,
    required this.end,
    required this.curve,
  });

  /// The begin time for this entry.
  final Duration begin;

  /// The end time for this entry.
  final Duration end;

  /// The curve used by this entry.
  final Curve curve;

  /// The effect associated with this entry.
  final Effect effect;

  /// Builds a sub-animation based on the properties of this entry.
  Animation<double> buildAnimation(AnimationController controller, {Curve? curve}) {
    return buildSubAnimation(controller, begin, end, curve ?? this.curve);
  }
}

/// Builds a sub-animation to the provided controller that runs from start to
/// end, with the provided curve. For example, it could create an animation that
/// runs from 300ms to 800ms with an easeOut, within a controller that has a
/// total duration of 1000ms.
///
/// Mostly used by effects classes.
Animation<double> buildSubAnimation(AnimationController controller, Duration begin, Duration end, Curve curve) {
  int ttlT = controller.duration?.inMicroseconds ?? 0;
  int beginT = begin.inMicroseconds, endT = end.inMicroseconds;
  return CurvedAnimation(
    parent: controller,
    curve: Interval(beginT / ttlT, endT / ttlT, curve: curve),
  );
}

/// Provides a common interface for [Animate] and [AnimateList] to attach [Effect] extensions.
mixin AnimateManager<T> {
  T addEffect(Effect effect) => throw (UnimplementedError());
  T addEffects(List<Effect> effects) {
    for (Effect o in effects) {
      addEffect(o);
    }
    return this as T;
  }
}
