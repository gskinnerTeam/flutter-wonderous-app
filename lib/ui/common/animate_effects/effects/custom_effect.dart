import 'package:flutter/widgets.dart';

import '../animate_effects.dart';

/// Provide an easy way to add custom effects via a build method. For example, this
/// would animate custom padding on the target from 0 to 40.
/// 
///     foo.animate().custom(duration: 1000.ms, end: 40, builder: (_, value, child) =>
///         Padding(padding: EdgeInsets.all(value), child: child))
/// 
/// Note that the above could also be accomplished by creating a custom effect class
/// that extends [Effect] and utilizes [AnimatedPadding].
@immutable
class CustomEffect extends Effect<double> {
  const CustomEffect({required this.builder, Duration? delay, Duration? duration, Curve? curve, double? begin, double? end})
      : super(delay: delay, duration: duration, curve: curve, begin: begin ?? 0.0, end: end ?? 1.0);

  final CustomEffectBuilder builder;

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, EffectEntry entry) {
    Animation<double> animation = buildAnimation(controller, entry);
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (ctx, child) => builder(ctx, animation.value, child!),
    );
  }
}

extension CustomEffectExtensions<T> on AnimateManager<T> {
  /// Adds a `.custom()` extension to [AnimateManager] ([Animate] and [AnimateList]).
  T custom({required CustomEffectBuilder builder, Duration? delay, Duration? duration, Curve? curve, double? begin, double? end}) =>
      addEffect(CustomEffect(builder: builder, delay: delay, duration: duration, curve: curve, begin: begin, end: end));
}

typedef CustomEffectBuilder = Widget Function(BuildContext context, double value, Widget child);
