import 'package:flutter/widgets.dart';

import '../animate_effects.dart';

/// Effect that allows you to toggle the behavior of a builder function based on whether
/// the time is before (`true`) or after (`false`) the effect's `delay`.
/// 
///     Animate().toggle(delay: 500.ms, builder: (_, value, __) =>
///       Text('${value ? "Before Delay" : "After Delay"}'));
/// 
/// This is also useful for triggering animation in "Animated" widgets.
/// 
///     foo.animate().toggle(delay: 500.ms, builder: (_, value, child) =>
///       AnimatedOpacity(opacity: value ? 0 : 1, child: child));
/// 
/// The child of `Animate` is passed through to the builder in the `child` param.
@immutable
class ToggleEffect extends Effect<void> {
  const ToggleEffect({required this.builder, Duration? delay}) : super(delay: delay, duration: Duration.zero);

  final ToggleEffectBuilder builder;

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, EffectEntry entry) {
    double ratio = getBeginRatio(controller, entry);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) =>  builder(context, controller.value < ratio, child),
    );
  }
}

extension ToggleEffectExtensions<T> on AnimateManager<T> {
  /// Adds a `.toggle()` extension to [AnimateManager] ([Animate] and [AnimateList]).
  T toggle({required ToggleEffectBuilder builder, Duration? delay}) => addEffect(ToggleEffect(builder: builder, delay: delay));
}

typedef ToggleEffectBuilder = Widget Function(BuildContext context, bool value, Widget child);