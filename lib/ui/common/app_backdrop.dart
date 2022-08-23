import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:wonders/common_libs.dart';

class AppBackdrop extends StatelessWidget {
  const AppBackdrop({
    Key? key,
    this.strength = 1,
    required this.child,
  }) : super(key: key);

  final double strength;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double normalStrength = clampDouble(strength, 0, 1);
    bool showBlur = false; // TODO SB: Remove this once we choose the rendering backend. Choose one method or the other.
    if (showBlur) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: normalStrength * 5.0, sigmaY: normalStrength * 5.0),
        child: child,
      );
    }
    return Container(
      color: $styles.colors.black.withOpacity(.6 * strength),
      child: child,
    );
  }
}
