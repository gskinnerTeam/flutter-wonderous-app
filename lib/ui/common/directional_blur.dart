import 'dart:ui';

import 'package:flutter/material.dart';

/// Rotates a child, blurs it on the x-axis, and the counter-rotates it back
class DirectionalBlur extends StatelessWidget {
  final double angle;
  final Widget child;
  final double blurAmount;

  const DirectionalBlur({Key? key, required this.angle, required this.child, required this.blurAmount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -angle,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blurAmount, tileMode: TileMode.clamp),
        child: Transform.rotate(angle: angle, child: child),
      ),
    );
  }
}
