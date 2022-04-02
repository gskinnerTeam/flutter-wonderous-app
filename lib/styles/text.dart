import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
class AppTextStyles {
  AppTextStyles(this.scale);
  final double scale;
  final TextStyle titleFont = TextStyle(fontFamily: 'Tenor', height: .9);
  final TextStyle contentFont = TextStyle(fontFamily: 'Raleway', height: 1.7);

  //TODO: Change these to final when design system has stopped changing
  TextStyle get caption =>
      contentFont.copyWith(fontSize: 16 * scale, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic);
  TextStyle get body => contentFont.copyWith(fontSize: 16 * scale);
  TextStyle get h1 => titleFont.copyWith(fontSize: 64 * scale);
  TextStyle get h2 => titleFont.copyWith(fontSize: 32 * scale);
  TextStyle get h3 => titleFont.copyWith(fontSize: 20 * scale);
  TextStyle get dropCase => titleFont.copyWith(fontSize: 49 * scale);
  TextStyle get quote => titleFont.copyWith(fontSize: 48 * scale);
}
