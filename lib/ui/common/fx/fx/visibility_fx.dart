import 'package:flutter/widgets.dart';

import '../fx.dart';

// TODO: GDS: possibly add other properties of visibility as params?

/// Effect that toggles the visibility of the target. Defaults to `begin=false, end=true`.
/// The `maintain` parameter is assigned to the [Visibility] properties 'maintainSize`,
/// `maintainAnimation`, `maintainState`, and `maintainSemantics`.
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

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => Visibility(
        child: child,
        visible: begin! == (controller.value < ratio),
        maintainSize: maintain,
        maintainAnimation: maintain,
        maintainState: maintain,
        maintainSemantics: maintain,
      ),
    );
  }
}

extension CallbackFXExtensions<T> on FXManager<T> {
  /// Adds a `.visibility()` extension to [FXManager] ([FXAnimate] and [FXAnimateList]).
  T visibility({Duration? delay, bool maintain = true, bool end = false}) =>
      addFX(VisibilityFX(delay: delay, end: end, maintain: maintain));

  /// Adds a `.show()` extension to [FXManager] ([FXAnimate] and [FXAnimateList]). This creates a VisibilityFX with
  /// `end=true`
  T show({Duration? delay, bool maintain = true}) => addFX(VisibilityFX(delay: delay, end: true, maintain: maintain));

  /// Adds a `.hide()` extension to [FXManager] ([FXAnimate] and [FXAnimateList]). This creates a VisibilityFX with
  /// `end=false`
  T hide({Duration? delay, bool maintain = true}) => addFX(VisibilityFX(delay: delay, end: false, maintain: maintain));
}
