import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/utils/color_utils.dart';

class AppColors {
  final Color bg = Color(0xFFEBE6E4);
  final Color accent1 = Color(0xFFE4935D);
  final Color accent2 = Color(0xFFBEABA1);
  final Color body = const Color(0xFF514F4D);
  final Color caption = const Color(0xFF7D7873);
  final Color greyStrong = const Color(0xFF272625);
  final Color text = Colors.white;
  final Color textOnBg = Colors.black;

  final Color wallFg = const Color(0xFFC1D9D1);
  final Color wallBg = const Color(0xFF70322E);

  final Color petraFg = const Color(0xFF1B2E60);
  final Color petraBg = const Color(0xFFDC762A);

  final Color colosseumFg = const Color(0xFFFEB547);
  final Color colosseumBg = const Color(0xFF1F9890);

  final Color chichenFg = const Color(0xFFE2CFBB);
  final Color chichenBg = const Color(0xFF204A1F);

  final Color machuFg = const Color(0xFFCBC424);
  final Color machuBg = const Color(0xFF60330A);

  final Color tajBg = const Color(0xFFED7967);
  final Color tajFg = const Color(0xFF80433F);

  final Color redeemerFg = const Color(0xFFED7967);
  final Color redeemerBg = const Color(0xFF255451);

  final Color gizaFg = const Color(0xFF8489D0);
  final Color gizaBg = const Color(0xFF2F2657);

  final bool isDark = false;

  Color wonderFg(WonderType type) {
    switch (type) {
      case WonderType.chichenItza:
        return chichenFg;
      case WonderType.tajMahal:
        return tajFg;
    }
  }

  Color wonderBg(WonderType type) {
    switch (type) {
      case WonderType.chichenItza:
        return chichenBg;
      case WonderType.tajMahal:
        return tajBg;
    }
  }

  Color shift(Color c, double d) => ColorUtils.shiftHsl(c, d * (isDark ? -1 : 1));
}

extension ColorThemeExtensions on AppColors {
  ThemeData toThemeData() {
    /// Create a TextTheme and ColorScheme, that we can use to generate ThemeData
    TextTheme txtTheme = (isDark ? ThemeData.dark() : ThemeData.light()).textTheme;
    Color txtColor = text;
    ColorScheme colorScheme = ColorScheme(
        // Decide how you want to apply your own custom them, to the MaterialApp
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: accent1,
        primaryContainer: accent1,
        secondary: accent1,
        secondaryContainer: accent1,
        background: bg,
        surface: bg,
        onBackground: txtColor,
        onSurface: txtColor,
        onError: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        error: Colors.red.shade400);

    /// Now that we have ColorScheme and TextTheme, we can create the ThemeData
    var t = ThemeData.from(textTheme: txtTheme, colorScheme: colorScheme)
        // We can also add on some extra properties that ColorScheme seems to miss
        .copyWith(
            textSelectionTheme: TextSelectionThemeData(cursorColor: accent1),
            highlightColor: accent1,
            toggleableActiveColor: accent1);

    /// Return the themeData which MaterialApp can now use
    return t;
  }
}