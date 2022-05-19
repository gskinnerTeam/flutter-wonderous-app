import 'package:flutter/widgets.dart';

import '../animate_effects.dart';

/// Custom effect that allows you to toggle the behavior of a builder function based on whether
/// it has passed it's `delay`.
/// 
///     Animate().toggle(delay: 500.ms, builder: (_, value, __) =>
///       Text('${value ? "Before" : "After"}'));
/// 
/// This is also useful for triggering animation in "Animated" widgets.
/// 
///     foo.animate().toggle(delay: 500.ms, builder: (_, value, child) =>
///       AnimatedOpacity(opacity: value ? 0 : 1, child: child));
/// 
/// The child of `Animate` is passed through to the builder in the `child` param.
@immutable
class ToggleEffect extends Effect<void> {
  final ToggleEffectBuilder builder;

  const ToggleEffect({required this.builder, Duration? delay}) : super(delay: delay, duration: Duration.zero);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, EffectEntry entry) {
    double ratio = entry.begin.inMilliseconds / (controller.duration?.inMilliseconds ?? 0);

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