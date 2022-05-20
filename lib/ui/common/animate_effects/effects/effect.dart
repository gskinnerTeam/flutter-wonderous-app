import 'package:flutter/widgets.dart';
import '../animate_effects.dart';

/// Abstract class that defines the required interface and helper methods for
/// all effect classes.
@immutable
abstract class Effect<T> {
  /// The specified delay for the effect. If null, will use the delay from the
  /// previous effect, or [Duration.zero] if this is the first effect.
  final Duration? delay;

  /// The specified duration for the effect. If null, will use the duration from the
  /// previous effect, or [Animate.defaultDuration] if this is the first effect.
  final Duration? duration;

  /// The specified curve for the effect. If null, will use the curve from the
  /// previous effect, or [Animate.defaultCurve] if this is the first effect.
  final Curve? curve;

  /// The begin value for the effect. If null, effects should use a reasonable
  /// default value when appropriate.
  final T? begin;

  /// The end value for the effect. If null, effects should use a reasonable 
  /// default value when appropriate.
  final T? end;

  const Effect({this.delay, this.duration, this.curve, this.begin, this.end});

  /// Builds the widgets necessary to implement the effect, based on the 
  /// provided [AnimationController] and [EffectEntry].
  Widget build(BuildContext context, Widget child, AnimationController controller, EffectEntry entry,) {
    throw UnimplementedError();
  }

  /// Helper method to build an animation based on the controller, entry, and 
  /// begin / end values.
  Animation<T> buildAnimation(AnimationController controller, EffectEntry entry) {
    return entry.buildAnimation(controller).drive(Tween<T>(begin: begin, end: end));
  }

  /// Helper method that returns a ratio corresponding to the beginning of the
  /// specified entry.
  double getBeginRatio(AnimationController controller, EffectEntry entry) {
    int ms = controller.duration?.inMilliseconds ?? 0;
    return ms == 0 ? 0 : entry.begin.inMilliseconds / ms;
  }

  /// Helper method that returns a ratio corresponding to the end of the
  /// specified entry.
  double getEndRatio(AnimationController controller, EffectEntry entry) {
    int ms = controller.duration?.inMilliseconds ?? 0;
    return ms == 0 ? 0 : entry.end.inMilliseconds / ms;
  }

  /// Helper method to check if the animation is currently running / active.
  bool isAnimationActive(Animation animation) {
    AnimationStatus status = animation.status;
    return status == AnimationStatus.forward || status == AnimationStatus.reverse;
  }
}
