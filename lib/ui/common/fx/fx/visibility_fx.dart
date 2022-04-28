import 'package:flutter/widgets.dart';

import '../fx.dart';

// TODO: GDS: possibly add other properties of visibility as params?

@immutable
class VisibilityFX extends AbstractFX<bool> {
  const VisibilityFX({Duration? delay, bool end = true, this.maintain = true})
      : super(
          delay: delay,
          duration: Duration.zero,
          begin: !end,
          end: end,
        );

  final bool maintain;

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    // instead of setting up an animation, we can optimize a bit to calculate the callback time once:
    double ratio = entry.begin.inMilliseconds / (controller.duration?.inMilliseconds ?? 0);
    bool visible = begin! == (controller.value < ratio);
    return Visibility(
      child: child,
      visible: visible,
      maintainSize: maintain,
      maintainAnimation: maintain,
      maintainState: maintain,
      maintainSemantics: maintain,
    );
  }
}

extension CallbackFXExtensions<T> on FXManager<T> {
  T show({Duration? delay, bool maintain = true}) => addFX(VisibilityFX(delay: delay, end: true, maintain: maintain));
  T hide({Duration? delay, bool maintain = true}) => addFX(VisibilityFX(delay: delay, end: false, maintain: maintain));
}
