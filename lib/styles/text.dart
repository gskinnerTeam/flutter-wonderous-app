import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension on TextStyle {
  // Stylistically cleaner revision of copyWith:
  // - scale is applied on its own and applied wherever needed
  // - parameters are labelled in pixels for clarity
  // - lineHeight is now in pixels rather than percent
  // - letterSpacing is now in percent rather than pixels (Figma, amirite?)
  TextStyle copyOver(double scale, {required double sizePx, double? heightPx, double? spacingPc, FontWeight? weight}) {
    return copyWith(
        fontSize: sizePx * scale,
        height: heightPx != null ? (heightPx / sizePx) * scale : height,
        letterSpacing: spacingPc != null ? sizePx * scale * spacingPc * 0.01 : letterSpacing,
        fontWeight: weight);
  }
}

@immutable
class AppTextStyles {
  AppTextStyles(this.scale);

  final double scale;
  final TextStyle titleFont = TextStyle(fontFamily: 'Tenor');
  final TextStyle contentFont = TextStyle(fontFamily: 'Raleway');

  //TODO: Change these to final when design system has stopped changing
  TextStyle get dropCase => titleFont.copyOver(scale, sizePx: 49);

  TextStyle get h1 => titleFont.copyOver(scale, sizePx: 64, heightPx: 62);
  TextStyle get h2 => titleFont.copyOver(scale, sizePx: 32, heightPx: 37.44);
  TextStyle get h3 => titleFont.copyOver(scale, sizePx: 14, heightPx: 16.44, spacingPc: 5, weight: FontWeight.w600);

  TextStyle get title1 => titleFont.copyOver(scale, sizePx: 15, heightPx: 17.55, spacingPc: 5);
  TextStyle get title2 => titleFont.copyOver(scale, sizePx: 14, heightPx: 16.38);
  TextStyle get title3 => contentFont.copyOver(scale, sizePx: 16, heightPx: 18.78, weight: FontWeight.w600);

  TextStyle get body1 => contentFont.copyOver(scale, sizePx: 16, heightPx: 26);
  TextStyle get body2 => contentFont.copyOver(scale, sizePx: 14, heightPx: 26, weight: FontWeight.w600);
  TextStyle get body3 => contentFont.copyOver(scale, sizePx: 24, heightPx: 26, weight: FontWeight.w600);
  TextStyle get body4 => contentFont.copyOver(scale, sizePx: 14, heightPx: 26);

  TextStyle get quote => titleFont.copyOver(scale, sizePx: 48, heightPx: 48, spacingPc: -10);
  TextStyle get caption =>
      contentFont.copyOver(scale, sizePx: 12, weight: FontWeight.w500).copyWith(fontStyle: FontStyle.italic);
  TextStyle get button => contentFont.copyOver(scale, sizePx: 12, weight: FontWeight.w600);
  TextStyle get tab => contentFont.copyOver(scale, sizePx: 12, weight: FontWeight.w600);
}
