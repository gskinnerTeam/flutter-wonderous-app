import 'package:flutter/widgets.dart';

import '../fx.dart';

@immutable
class BuildFX extends AbstractFX<double> {
  final BuildFXBuilder builder;

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
extension BuildFXExtensions<T> on FXManager<T> {
  T build(BuildFXBuilder builder, {Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) =>
    addFX(BuildFX(builder, delay: delay, duration: duration, curve: curve, begin:begin, end: end));
}

typedef BuildFXBuilder = Widget Function(BuildContext context, double ratio, Widget child);