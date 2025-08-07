import 'package:flutter/cupertino.dart';

class ColorUtils {
  static Color shiftHsl(Color c, [double amt = 0]) {
    var hslc = HSLColor.fromColor(c);
    return hslc.withLightness((hslc.lightness + amt).clamp(0.0, 1.0)).toColor();
  }

  static Color parseHex(String value) => Color(int.parse(value.substring(1, 7), radix: 16) + 0xFF000000);

  static Color blend(Color dst, Color src, double opacity) {
    return Color.fromARGB(
      255,
      ((dst.r * 255.0).round() * (1.0 - opacity) + (src.r * 255.0).round() * opacity).toInt(),
      ((dst.g * 255.0).round() * (1.0 - opacity) + (src.g * 255.0).round() * opacity).toInt(),
      ((dst.b * 255.0).round() * (1.0 - opacity) + (src.b * 255.0).round() * opacity).toInt(),
    );
  }
}
