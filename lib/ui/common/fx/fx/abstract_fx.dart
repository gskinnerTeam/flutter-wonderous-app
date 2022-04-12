import 'package:flutter/widgets.dart';
import '../fx.dart';

// Abstract class that defines the required interface and a number of helper
// methods for effect classes.
@immutable
abstract class AbstractFX<T> {
  final Duration? delay;
  final Duration? duration;
  final Curve? curve;

  final T? begin;
  final T? end;
  
  const AbstractFX({this.delay, this.duration, this.curve, this.begin, this.end});

  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    throw UnimplementedError();
  }

  Animation<T> buildAnimation(AnimationController controller, FXEntry entry) {
    return entry.buildAnimation(controller).drive(Tween<T>(begin: begin, end: end));
  }

  bool isAnimationActive(Animation animation) {
    AnimationStatus status = animation.status;
    return status == AnimationStatus.forward || status == AnimationStatus.reverse;
  }
}