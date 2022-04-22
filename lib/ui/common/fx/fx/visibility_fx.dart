import 'package:flutter/widgets.dart';

import '../fx.dart';

// todo: possibly add other properties of visibility as params?
// todo: also maybe a `maintain` param that shortcuts all of them

@immutable
class VisibilityFX extends AbstractFX<bool> {
  const VisibilityFX({Duration? delay, bool end = true})
      : super(delay: delay, duration: Duration.zero, begin: !end, end: end,);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    // instead of setting up an animation, we can optimize a bit to calculate the callback time once:
    double ratio = entry.begin.inMilliseconds / (controller.duration?.inMilliseconds ?? 0);
    bool visible = begin! == (controller.value < ratio);
    return Visibility(
      child: child,
      visible: visible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
    );
  }
}

extension CallbackFXExtensions<T> on FXManager<T> {
  T show({Duration? delay}) => addFX(VisibilityFX(delay: delay, end: true));
  T hide({Duration? delay}) => addFX(VisibilityFX(delay: delay, end: false));
}
