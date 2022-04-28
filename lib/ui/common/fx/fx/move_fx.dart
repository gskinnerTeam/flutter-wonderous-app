import 'package:flutter/widgets.dart';

import '../fx.dart';

@immutable
class MoveFX extends AbstractFX<Offset> {
  const MoveFX({Duration? delay, Duration? duration, Curve? curve, Offset? begin, Offset? end})
      : super(
            delay: delay,
            duration: duration,
            curve: curve,
            begin: begin ?? const Offset(0, -16),
            end: end ?? Offset.zero);

  @override
  Widget build(BuildContext context, Widget child, AnimationController controller, FXEntry entry) {
    Animation<Offset> animation = buildAnimation(controller, entry);
    return AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (ctx, child) {
          Offset offset = animation.value;
          return Transform.translate(offset: offset, child: child);
        });
  }
}

extension MoveFXExtensions<T> on FXManager<T> {
  T move({Duration? delay, Duration? duration, Curve? curve, Offset? begin, Offset? end}) =>
      addFX(MoveFX(delay: delay, duration: duration, curve: curve, begin: begin, end: end));
}
