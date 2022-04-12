import 'package:flutter/material.dart';

class Particle {
  // Painter properties:
  double x;
  double y;
  double scale;
  double rotation;
  int frame;
  Color color;

  // Optional extra data:
  double vx; // velocity x
  double vy; // velocity y
  double lifespan;
  double age;
  late Map<String, double> values;
  late Map<String, dynamic> data;

  Particle({
    this.x = 0.0,
    this.y = 0.0,
    this.scale = 1.0,
    this.rotation = 0.0,
    this.frame = 0,
    this.color = Colors.black,

    this.vx = 0.0,
    this.vy = 0.0,
    this.lifespan = 0.0,
    this.age = 0.0,
    values,
    data,
  }) {
    this.values = values ?? {};
    this.data = data ?? {};
  }

  // Returns an offset representing this particles, optionally with a transformation applied.
  Offset toOffset([Matrix4? transform]) {
    Offset o = Offset(x, y);
    if (transform == null) {
      return o;
    }
    return MatrixUtils.transformPoint(transform, o);
  }

  // updates any values passed, and runs basic logic:
  // - if neither x/y are specified, adds vx and vy to current values
  // - if age is not specified, increments it by one
  void update({
    double? x, double? y,
    double? scale, double? rotation,
    int? frame, Color? color,
    double? vx, double? vy,
    double? lifespan, double? age,
  }) {
    if (x != null) this.x = x;
    if (y != null) this.y = y;
    if (scale != null) this.scale = scale;
    if (rotation != null) this.rotation = rotation;
    if (frame != null) this.frame = frame;
    if (color != null) this.color = color;

    if (vx != null) this.vx = vx;
    if (vy != null) this.vy = vy;
    if (lifespan != null) this.lifespan = lifespan;
    this.age = age ?? this.age + 1;

    if (x == null && y == null) {
      this.x += this.vx;
      this.y += this.vy;
    }
  }
}