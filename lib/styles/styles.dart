// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:wonders/common_libs.dart';

export 'colors.dart';

final $styles = AppStyle();

@immutable
class AppStyle {
  /// The current theme colors for the app
  final AppColors colors = AppColors();

  /// Rounded edge corner radii
  late final _Corners corners = _Corners();

  late final _Shadows shadows = _Shadows();

  /// Padding and margin values
  late final _Insets insets = _Insets();

  /// Text styles
  late final _Text text = _Text();

  /// Animation Durations
  final _Times times = _Times();

  /// Shared sizes
  final _Sizes sizes = _Sizes();
}

@immutable
class _Text {
  final Map<String, TextStyle> _titleFonts = {
    'en': TextStyle(fontFamily: 'Tenor'),
  };

  final Map<String, TextStyle> _monoTitleFonts = {
    'en': TextStyle(fontFamily: 'B612Mono'),
  };

  final Map<String, TextStyle> _quoteFonts = {
    'en': TextStyle(fontFamily: 'Cinzel'),
    'zh': TextStyle(fontFamily: 'MaShanZheng'),
  };

  final Map<String, TextStyle> _wonderTitleFonts = {
    'en': TextStyle(fontFamily: 'Yeseva'),
  };

  final Map<String, TextStyle> _contentFonts = {
    'en': TextStyle(fontFamily: 'Raleway', fontFeatures: const [
      FontFeature.enable('dlig'),
      FontFeature.enable('kern'),
    ]),
  };

  TextStyle _getFontForLocale(Map<String, TextStyle> fonts) {
    if (localeLogic.isLoaded) {
      return fonts.entries.firstWhere((x) => x.key == $strings.localeName, orElse: () => fonts.entries.first).value;
    } else {
      return fonts.entries.first.value;
    }
  }

  TextStyle get titleFont => _getFontForLocale(_titleFonts);
  TextStyle get quoteFont => _getFontForLocale(_quoteFonts);
  TextStyle get wonderTitleFont => _getFontForLocale(_wonderTitleFonts);
  TextStyle get contentFont => _getFontForLocale(_contentFonts);
  TextStyle get monoTitleFont => _getFontForLocale(_monoTitleFonts);

  late final TextStyle dropCase = copy(quoteFont, sizePx: 56, heightPx: 20);

  late final TextStyle wonderTitle = copy(wonderTitleFont, sizePx: 64, heightPx: 56);

  late final TextStyle h1 = copy(titleFont, sizePx: 64, heightPx: 62);
  late final TextStyle h2 = copy(titleFont, sizePx: 32, heightPx: 46);
  late final TextStyle h3 = copy(titleFont, sizePx: 24, heightPx: 36, weight: FontWeight.w600);
  late final TextStyle h4 = copy(contentFont, sizePx: 14, heightPx: 23, spacingPc: 5, weight: FontWeight.w600);

  late final TextStyle title1 = copy(titleFont, sizePx: 16, heightPx: 26, spacingPc: 5);
  late final TextStyle title2 = copy(titleFont, sizePx: 14, heightPx: 16.38);

  late final TextStyle body = copy(contentFont, sizePx: 16, heightPx: 27);
  late final TextStyle bodyBold = copy(contentFont, sizePx: 16, heightPx: 26, weight: FontWeight.w600);
  late final TextStyle bodySmall = copy(contentFont, sizePx: 14, heightPx: 23);
  late final TextStyle bodySmallBold = copy(contentFont, sizePx: 14, heightPx: 23, weight: FontWeight.w600);

  late final TextStyle quote1 = copy(quoteFont, sizePx: 32, heightPx: 40, weight: FontWeight.w600, spacingPc: -3);
  late final TextStyle quote2 = copy(quoteFont, sizePx: 21, heightPx: 32, weight: FontWeight.w400);
  late final TextStyle quote2Sub = copy(body, sizePx: 16, heightPx: 40, weight: FontWeight.w400);

  late final TextStyle caption =
      copy(contentFont, sizePx: 12, heightPx: 18, weight: FontWeight.w500).copyWith(fontStyle: FontStyle.italic);

  late final TextStyle callout =
      copy(contentFont, sizePx: 16, heightPx: 26, weight: FontWeight.w600).copyWith(fontStyle: FontStyle.italic);
  late final TextStyle btn = copy(titleFont, sizePx: 12, weight: FontWeight.w600, heightPx: 13.2);

  TextStyle copy(TextStyle style, {required double sizePx, double? heightPx, double? spacingPc, FontWeight? weight}) {
    return style.copyWith(
        fontSize: sizePx,
        height: heightPx != null ? (heightPx / sizePx) : style.height,
        letterSpacing: spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
        fontWeight: weight);
  }
}

@immutable
class _Times {
  final Duration fast = Duration(milliseconds: 300);
  final Duration med = Duration(milliseconds: 600);
  final Duration slow = Duration(milliseconds: 900);
  final Duration pageTransition = Duration(milliseconds: 200);
}

@immutable
class _Corners {
  late final double sm = 4;
  late final double md = 8;
  late final double lg = 32;
}

// TODO: add, @immutable when design is solidified
class _Sizes {
  double get maxContentWidth => 800;
}

@immutable
class _Insets {
  late final double xxs = 4;
  late final double xs = 8;
  late final double sm = 16;
  late final double md = 24;
  late final double lg = 32;
  late final double xl = 48;
  late final double xxl = 56;
  late final double offset = 80;
}

@immutable
class _Shadows {
  final textSoft = [
    Shadow(color: Colors.black.withOpacity(.25), offset: Offset(0, 2), blurRadius: 4),
  ];
  final text = [
    Shadow(color: Colors.black.withOpacity(.6), offset: Offset(0, 2), blurRadius: 2),
  ];
  final textStrong = [
    Shadow(color: Colors.black.withOpacity(.6), offset: Offset(0, 4), blurRadius: 6),
  ];
}
