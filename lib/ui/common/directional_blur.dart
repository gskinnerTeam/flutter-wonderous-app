import 'dart:ui';

import 'package:flutter/material.dart';

/// Rotates a child, blurs it on the x-axis, and the counter-rotates it back, giving the
/// appearance of motion blur in a given direction.
class DirectionalBlur extends StatelessWidget {
  /// Direction of blur, in rads.
  final double rotation;

  /// Strength of blur, in pixels.
  final double blurAmount;

  final Widget child;

  const DirectionalBlur({Key? key, required this.rotation, required this.child, required this.blurAmount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -rotation,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blurAmount, tileMode: TileMode.clamp),
        child: Transform.rotate(angle: rotation, child: child),
      ),
    );
  }
}
