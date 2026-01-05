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
      ((dst.r * (1.0 - opacity) + src.r * opacity) * 255).toInt(),
      ((dst.g * (1.0 - opacity) + src.g * opacity) * 255).toInt(),
      ((dst.b * (1.0 - opacity) + src.b * opacity) * 255).toInt(),
    );
  }
}
