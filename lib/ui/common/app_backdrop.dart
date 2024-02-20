import 'dart:ui';

import 'package:wonders/common_libs.dart';

class AppBackdrop extends StatelessWidget {
  const AppBackdrop({
    super.key,
    this.strength = 1,
    this.child,
  });

  final double strength;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final double normalStrength = clampDouble(strength, 0, 1);
    if (settingsLogic.useBlurs) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: normalStrength * 15, sigmaY: normalStrength * 15),
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
