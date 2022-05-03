import 'package:flutter/widgets.dart';
import '../fx.dart';

/// Abstract class that defines the required interface and helper methods for effect classes.
@immutable
abstract class AbstractFX<T> {
  /// The specified delay for the effect. If null, will use the delay from the
  /// previous effect, or `Duration.zero` if this is the first effect.
  final Duration? delay;

  /// The specified duration for the effect. If null, will use the duration from the
  /// previous effect, or `FXAnimate.defaultDuration` if this is the first effect.
  final Duration? duration;

  /// The specified curve for the effect. If null, will use the curve from the
  /// previous effect, or `FXAnimate.defaultCurve` if this is the first effect.
  final Curve? curve;

  /// The begin value for the effect. If null, effects
  /// should use a reasonable default value when appropriate.
  final T? begin;

  /// The end value for the effect. If null, effects
  /// should use a reasonable default value when appropriate.
  final T? end;

  const AbstractFX({this.delay, this.duration, this.curve, this.begin, this.end});

  /// Builds the widgets necessary to implement the effect, based on the provided
  /// AnimationController and FXEntry.
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    throw UnimplementedError();
  }

  /// Helper method to build an animation based on the controller, entry, and 
  /// begin / end values.
  Animation<T> buildAnimation(AnimationController controller, FXEntry entry) {
    return entry.buildAnimation(controller).drive(Tween<T>(begin: begin, end: end));
  }

  /// Helper method to check if the animation is currently running / active.
  bool isAnimationActive(Animation animation) {
    AnimationStatus status = animation.status;
    return status == AnimationStatus.forward || status == AnimationStatus.reverse;
  }
}
