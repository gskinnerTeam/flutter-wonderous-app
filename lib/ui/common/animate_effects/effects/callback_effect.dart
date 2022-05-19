import 'package:flutter/widgets.dart';

import '../animate_effects.dart';

/// Effect that calls a callback function at a particular point in the animation
/// (specified via `delay`).
@immutable
class CallbackEffect extends Effect<void> {
  final Function() callback;

  const CallbackEffect(this.callback, {Duration? delay}) : super(delay: delay, duration: Duration.zero);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, EffectEntry entry) {
    // instead of setting up an animation, we can optimize a bit to calculate the callback time once:
    double ratio = entry.begin.inMilliseconds / (controller.duration?.inMilliseconds ?? 0);
    bool isComplete = false;
    controller.addListener(() {
      if (!isComplete && controller.value >= ratio) {
        isComplete = true;
        callback();
      }
    });
    return child;
  }
}

extension CallbackEffectExtensions<T> on AnimateManager<T> {
  /// Adds a `.callback()` extension to [AnimateManager] ([Animate] and [AnimateList]).
  T callback(Function() callback, {Duration? delay}) => addEffect(CallbackEffect(callback, delay: delay));
}
