import 'package:flutter/widgets.dart';

import '../fx.dart';
import 'abstract_fx.dart';

@immutable
class ListenFX extends AbstractFX<double> {
  final Function(double) callback;
  final bool clamp;

  const ListenFX(this.callback, {Duration? delay, Duration? duration, Curve? curve, double? begin, double? end, this.clamp=true}) :
    super(delay:delay, duration:duration, curve:curve, begin:begin ?? 0.0, end:end ?? 1.0);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    // build an animation without a curve, so we get a linear 0-1 value back so we can determine start / end.
    Animation<double> animation = entry.buildAnimation(controller, curve: Curves.linear);
    double prev = 0.0, begin = this.begin ?? 0.0, end = this.end ?? 1.0;
    animation.addListener(() {
      double value = animation.value;
      if (!clamp || value != prev) {
        callback(begin + (end-begin) * entry.curve.transform(value));
        prev = value;
      }
    });
    return child;
  }
}
extension ListenFXExtensions<T> on FXManager<T> {
  T listen(Function(double) callback, {Duration? delay, Duration? duration, Curve? curve, double? begin, double? end, bool clamp=true}) =>
    addFX(ListenFX(callback, delay: delay, duration: duration, curve: curve, begin:begin, end: end, clamp:clamp));
}