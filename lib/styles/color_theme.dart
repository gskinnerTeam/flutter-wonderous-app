import 'package:flutter/material.dart';

enum ColorThemeType { orange, green }

class ColorTheme {
  const ColorTheme._({
    required this.accent,
    this.bg = Colors.white,
    this.surface1 = const Color(0xffeeeeee),
    this.fg = Colors.black,
    this.isDark = false,
  });
  final Color bg;
  final Color surface1;
  final Color fg;
  final Color accent;
  final bool isDark;

  factory ColorTheme(ColorThemeType type) {
    switch (type) {
      case ColorThemeType.green:
        return ColorTheme._(accent: Colors.green);
      default:
        return ColorTheme._(accent: Colors.orange);
    }
  }
}

extension ColorThemeExtensions on ColorTheme {
  ThemeData toThemeData() {
    /// Create a TextTheme and ColorScheme, that we can use to generate ThemeData
    TextTheme txtTheme = (isDark ? ThemeData.dark() : ThemeData.light()).textTheme;
    Color txtColor = fg;
    ColorScheme colorScheme = ColorScheme(
        // Decide how you want to apply your own custom them, to the MaterialApp
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: accent,
        primaryContainer: accent,
        secondary: accent,
        secondaryContainer: accent,
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
            textSelectionTheme: TextSelectionThemeData(cursorColor: accent),
            highlightColor: accent,
            toggleableActiveColor: accent);

    /// Return the themeData which MaterialApp can now use
    return t;
  }
}
