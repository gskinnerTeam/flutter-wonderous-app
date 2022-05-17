import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
class AppTextStyles {
  AppTextStyles(this.scale);

  final double scale;
  final TextStyle titleFont = TextStyle(fontFamily: 'Tenor');
  final TextStyle quoteFont = TextStyle(fontFamily: 'Cinzel');
  final TextStyle wonderTitleFont = TextStyle(fontFamily: 'Yeseva');
  TextStyle get contentFont => TextStyle(fontFamily: 'Raleway', fontFeatures: const [
        FontFeature.enable('dlig'),
      ]);

  late TextStyle dropCase = copy(quoteFont, sizePx: 56, heightPx: 20);

  TextStyle get wonderTitle => copy(wonderTitleFont, sizePx: 64, heightPx: 56);

  late TextStyle h1 = copy(titleFont, sizePx: 64, heightPx: 62);
  late TextStyle h2 = copy(titleFont, sizePx: 32, heightPx: 46);
  late TextStyle h3 = copy(titleFont, sizePx: 24, heightPx: 36, weight: FontWeight.w600);
  late TextStyle h4 = copy(titleFont, sizePx: 14, heightPx: 23, spacingPc: 5, weight: FontWeight.w600);

  late TextStyle title1 = copy(titleFont, sizePx: 16, heightPx: 26, spacingPc: 5);
  late TextStyle title2 = copy(titleFont, sizePx: 14, heightPx: 16.38);

  TextStyle get body => copy(contentFont, sizePx: 16, heightPx: 27);
  late TextStyle bodyBold = copy(contentFont, sizePx: 16, heightPx: 26, weight: FontWeight.w600);
  late TextStyle bodySmall = copy(contentFont, sizePx: 14, heightPx: 23);
  late TextStyle bodySmallBold = copy(contentFont, sizePx: 14, heightPx: 23, weight: FontWeight.w600);

  TextStyle get quote1 => copy(quoteFont, sizePx: 36, heightPx: 40, weight: FontWeight.w600, spacingPc: -3);
  late TextStyle quote2 = copy(quoteFont, sizePx: 21, heightPx: 32, weight: FontWeight.w400);
  late TextStyle quote2Sub = copy(body, sizePx: 16, heightPx: 40, weight: FontWeight.w400);

  late TextStyle callout =
      copy(contentFont, sizePx: 16, heightPx: 26, weight: FontWeight.w600).copyWith(fontStyle: FontStyle.italic);
  late TextStyle btn = copy(titleFont, sizePx: 12, weight: FontWeight.w600, heightPx: 13.2);

  TextStyle copy(TextStyle style, {required double sizePx, double? heightPx, double? spacingPc, FontWeight? weight}) {
    return style.copyWith(
        fontSize: sizePx * scale,
        height: heightPx != null ? (heightPx / sizePx) * scale : style.height,
        letterSpacing: spacingPc != null ? sizePx * scale * spacingPc * 0.01 : style.letterSpacing,
        fontWeight: weight);
  }
}
