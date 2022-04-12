import 'package:flutter/widgets.dart';

import '../fx.dart';
import 'abstract_fx.dart';

@immutable
class BuildFX extends AbstractFX<double> {
  final Widget Function(BuildContext, double, Widget) builder;

  const BuildFX(this.builder, {Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) :
    super(delay:delay, duration:duration, curve:curve, begin:begin ?? 0.0, end:end ?? 1.0);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    Animation<double> animation = buildAnimation(controller, entry);
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (ctx, child) => builder(ctx, animation.value, child!),
    );
  }
}
extension ListenFXExtensions<T> on FXManager<T> {
  T build(builder, {Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) =>
    addFX(BuildFX(builder, delay: delay, duration: duration, curve: curve, begin:begin, end: end));
}