
import 'dart:collection';
import 'package:flutter/widgets.dart';

import 'fx/abstract_fx.dart';

part 'fx_animate_list.dart';
part 'fx_animate.dart';
part 'fx_run_animated.dart';
part 'fx_builder.dart';
part 'fx_entry.dart';

// FXManager provides a common interface for FXAnimate and FXAnimateList for attaching FX extensions
mixin FXManager<T> {
  T addFX(AbstractFX fx) => throw (UnimplementedError());
  T addFXList(List<AbstractFX> fx) => throw (UnimplementedError());
}

// Builds a sub-animation to the provided controller that runs from start to
// end, with the provided curve. For example, it could create an animation that 
// runs from 300ms to 800ms with an easeOut, within a controller that has a
// total duration of 1000ms.
Animation<double> _buildAnimation(
    AnimationController controller, Duration begin, Duration end, Curve curve) {
  int ttlT = controller.duration?.inMicroseconds ?? 0;
  int beginT = begin.inMicroseconds, endT = end.inMicroseconds;
  return CurvedAnimation(
    parent: controller,
    curve: Interval(beginT / ttlT, endT / ttlT, curve: curve),
  );
}

typedef FXAnimateCallback = void Function(
  AnimationController controller,
);
