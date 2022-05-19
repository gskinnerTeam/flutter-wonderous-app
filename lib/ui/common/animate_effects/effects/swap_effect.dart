import 'package:flutter/widgets.dart';

import '../animate_effects.dart';

/// Effect that swaps out the incoming child for a new child at a particular point in time. This includes all preceeding
/// effects. For example, this would fade out `foo`, swap it for `Bar()` (including discarding the `fadeOut` effect) and
/// fade it in.
/// 
///     foo.animate().fadeOut(duration: 500.ms).swap(
///       delay: 500.ms,
///       builder: () => Bar().fadeIn(),
///     )
/// 
/// It uses a builder so that the effect can be reused, but note that the builder is only called once.
@immutable
class SwapEffect extends Effect<void> {
  final WidgetBuilder builder;

  const SwapEffect({required this.builder, Duration? delay}) : super(delay: delay, duration: Duration.zero);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, EffectEntry entry) {
    // instead of setting up an animation, we can optimize a bit to calculate the callback time once:
    double ratio = entry.begin.inMilliseconds / (controller.duration?.inMilliseconds ?? 0);
    Widget endChild = builder(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => (controller.value < ratio) ? child : endChild,
    );
  }
}

extension SwapEffectExtensions<T> on AnimateManager<T> {
  /// Adds a `.swap()` extension to [AnimateManager] ([Animate] and [AnimateList]).
  T swap({required WidgetBuilder builder, Duration? delay}) => addEffect(SwapEffect(builder: builder, delay: delay));
}
