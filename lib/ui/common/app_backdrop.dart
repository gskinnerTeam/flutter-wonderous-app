import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:wonders/common_libs.dart';

class AppBackdrop extends StatelessWidget {
  const AppBackdrop({
    Key? key,
    this.strength = 1,
    this.child,
  }) : super(key: key);

  final double strength;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final double normalStrength = clampDouble(strength, 0, 1);
    if (settingsLogic.useBlurs) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: normalStrength * 15.0, sigmaY: normalStrength * 15.0),
        child: child ?? SizedBox.expand(),
      );
    }
    final fill = Container(color: $styles.colors.black.withOpacity(.8 * strength));
    return child == null
        ? fill
        : Stack(
            children: [
              child!,
              Positioned.fill(child: fill),
            ],
          );
  }
}
