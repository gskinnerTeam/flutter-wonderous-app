import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
class AppTextStyles {
  AppTextStyles(this.scale);

  final double scale;
  final TextStyle titleFont = TextStyle(fontFamily: 'Tenor');
  final TextStyle contentFont = TextStyle(fontFamily: 'Raleway');

  //TODO: Change these from getters to final vars when design system has stopped changing
  TextStyle get dropCase => copy(titleFont, sizePx: 49, heightPx: 20);

  TextStyle get h1 => copy(titleFont, sizePx: 64, heightPx: 62);
  TextStyle get h2 => copy(titleFont, sizePx: 32, heightPx: 37.44);
  TextStyle get h3 => copy(titleFont, sizePx: 14, heightPx: 16.44, spacingPc: 5, weight: FontWeight.w600);

  TextStyle get title1 => copy(titleFont, sizePx: 15, heightPx: 17.55, spacingPc: 5);
  TextStyle get title2 => copy(titleFont, sizePx: 14, heightPx: 16.38);
  TextStyle get title3 => copy(contentFont, sizePx: 16, heightPx: 18.78, weight: FontWeight.w600);

  TextStyle get body1 => copy(contentFont, sizePx: 16, heightPx: 26);
  TextStyle get body2 => copy(contentFont, sizePx: 14, heightPx: 26, weight: FontWeight.w600);
  TextStyle get body3 => copy(contentFont, sizePx: 24, heightPx: 26, weight: FontWeight.w600);
  TextStyle get body4 => copy(contentFont, sizePx: 14, heightPx: 26);

  TextStyle get quote => copy(titleFont, sizePx: 42, heightPx: 42, spacingPc: -10, weight: FontWeight.w500);
  TextStyle get caption => copy(contentFont, sizePx: 12, weight: FontWeight.w500).copyWith(fontStyle: FontStyle.italic);
  TextStyle get button => copy(titleFont, sizePx: 12, weight: FontWeight.w600, heightPx: 13.2);
  TextStyle get tab => copy(contentFont, sizePx: 12, weight: FontWeight.w600);

  TextStyle copy(TextStyle style, {required double sizePx, double? heightPx, double? spacingPc, FontWeight? weight}) {
    return style.copyWith(
        fontSize: sizePx * scale,
        height: heightPx != null ? (heightPx / sizePx) * scale : style.height,
        letterSpacing: spacingPc != null ? sizePx * scale * spacingPc * 0.01 : style.letterSpacing,
        fontWeight: weight);
  }
}
