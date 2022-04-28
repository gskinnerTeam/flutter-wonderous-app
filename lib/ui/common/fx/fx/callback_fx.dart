import 'package:flutter/widgets.dart';
import 'package:wonders/ui/common/fx/fx.dart';

@immutable
class CallbackFX extends AbstractFX<void> {
  final Function() callback;

  const CallbackFX(this.callback, {Duration? delay}) : super(delay: delay, duration: Duration.zero);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
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

extension CallbackFXExtensions<T> on FXManager<T> {
  T callback(Function() callback, {Duration? delay}) => addFX(CallbackFX(callback, delay: delay));
}
