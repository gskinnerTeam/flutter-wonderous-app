import 'package:flutter/widgets.dart';

import '../fx.dart';

// todo: possibly add other properties of visibility as params?

@immutable
class VisibilityFX extends AbstractFX<bool> {
  const VisibilityFX({Duration? delay, bool begin = false})
      : super(delay: delay, duration: Duration.zero, begin: begin);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    // instead of setting up an animation, we can optimize a bit to calculate the callback time once:
    double ratio = entry.begin.inMilliseconds / (controller.duration?.inMilliseconds ?? 0);
    bool visible = begin! == (controller.value < ratio);
    return visible
        ? child
        : Visibility(
            child: child,
            visible: false,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
          );
  }
}

extension CallbackFXExtensions<T> on FXManager<T> {
  T show({Duration? delay}) => addFX(VisibilityFX(delay: delay, begin: false));
  T hide({Duration? delay}) => addFX(VisibilityFX(delay: delay, begin: true));
}
