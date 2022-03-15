import 'package:flutter/material.dart';

@immutable
class AppTextStyles {
  AppTextStyles(this.scale);
  final double scale;
  late final _baseFont1 = TextStyle(fontSize: 12 * scale);

  late final body = _baseFont1.copyWith(fontSize: 14 * scale);
  late final h1 = _baseFont1.copyWith(fontSize: 32 * scale);
  late final h2 = _baseFont1.copyWith(fontSize: 24 * scale);
}
