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
  TextStyle get h2 => copy(titleFont, sizePx: 32, heightPx: 46);
  TextStyle get h3 => copy(contentFont, sizePx: 24, heightPx: 36, weight: FontWeight.w600);
  TextStyle get h4 => copy(titleFont, sizePx: 14, heightPx: 23, spacingPc: 5, weight: FontWeight.w600);

  TextStyle get title1 => copy(titleFont, sizePx: 16, heightPx: 26, spacingPc: 5);
  TextStyle get title2 => copy(titleFont, sizePx: 14, heightPx: 16.38);
  //TextStyle get title3 => copy(contentFont, sizePx: 16, heightPx: 18.78, weight: FontWeight.w600);

  TextStyle get body => copy(contentFont, sizePx: 16, heightPx: 26);
  TextStyle get bodyBold => copy(contentFont, sizePx: 16, heightPx: 26, weight: FontWeight.w600);
  TextStyle get bodySmall => copy(contentFont, sizePx: 14, heightPx: 23);
  TextStyle get bodySmallBold => copy(contentFont, sizePx: 14, heightPx: 23, weight: FontWeight.w600);

  TextStyle get quote => copy(titleFont, sizePx: 42, heightPx: 42, spacingPc: -10, weight: FontWeight.w500);
  TextStyle get caption => copy(contentFont, sizePx: 12, weight: FontWeight.w500).copyWith(fontStyle: FontStyle.italic);
  TextStyle get btn => copy(titleFont, sizePx: 12, weight: FontWeight.w600, heightPx: 13.2);

  TextStyle copy(TextStyle style, {required double sizePx, double? heightPx, double? spacingPc, FontWeight? weight}) {
    return style.copyWith(
        fontSize: sizePx * scale,
        height: heightPx != null ? (heightPx / sizePx) * scale : style.height,
        letterSpacing: spacingPc != null ? sizePx * scale * spacingPc * 0.01 : style.letterSpacing,
        fontWeight: weight);
  }
}
