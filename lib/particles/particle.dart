import 'package:flutter/material.dart';

// Stores the data associated with a basic particle.
class Particle {
  double x;
  double y;
  double scale;
  double rotation;
  int frame;
  Color color;

  Particle({
    this.x = 0.0,
    this.y = 0.0,
    this.scale = 1.0,
    this.rotation = 0.0,
    this.frame = 0,
    this.color = Colors.transparent
  });

  // Returns an offset representing this particles, optionally with a transformation applied.
  Offset toOffset([Matrix4? transform]) {
    Offset o = Offset(x, y);
    if (transform == null) {
      return o;
    }
    return MatrixUtils.transformPoint(transform, o);
  }
}
