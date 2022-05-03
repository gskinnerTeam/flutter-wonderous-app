import 'package:flutter/widgets.dart';

import '../fx.dart';

/// Provide an easy way to add custom effects via a build method. For example, this
/// would animate custom padding on the target from 0 to 40.
/// 
///     foo.fx().custom(duration: 1000.ms, end: 40, builder: (_, value, child) =>
///         Padding(padding: EdgeInsets.all(value), child: child))
/// 
/// Note that the above could also be accomplished by creating a custom effect class
/// that extends AbstractFX and utilizes AnimatedPadding.
@immutable
class CustomFX extends AbstractFX<double> {
  final CustomFXBuilder builder;

  const CustomFX(this.builder, {Duration? delay, Duration? duration, Curve? curve, double? begin, double? end})
      : super(delay: delay, duration: duration, curve: curve, begin: begin ?? 0.0, end: end ?? 1.0);

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

extension CustomFXExtensions<T> on FXManager<T> {
  /// Adds a `.custom()` extension to [FXManager] ([FXAnimate] and [FXAnimateList]).
  T custom(CustomFXBuilder builder, {Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) =>
      addFX(CustomFX(builder, delay: delay, duration: duration, curve: curve, begin: begin, end: end));
}

typedef CustomFXBuilder = Widget Function(BuildContext context, double value, Widget child);
