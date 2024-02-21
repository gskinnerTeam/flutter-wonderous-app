import 'package:wonders/common_libs.dart';

extension WonderColorExtensions on WonderType {
  Color get bgColor {
    return switch (this) {
      WonderType.pyramidsGiza => const Color(0xFF16184D),
      WonderType.greatWall => const Color(0xFF642828),
      WonderType.petra => const Color(0xFF444B9B),
      WonderType.colosseum => const Color(0xFF1E736D),
      WonderType.chichenItza => const Color(0xFF164F2A),
      WonderType.machuPicchu => const Color(0xFF0E4064),
      WonderType.tajMahal => const Color(0xFFC96454),
      WonderType.christRedeemer => const Color(0xFF1C4D46)
    };
  }

  Color get fgColor {
    return switch (this) {
      WonderType.pyramidsGiza => const Color(0xFF444B9B),
      WonderType.greatWall => const Color(0xFF688750),
      WonderType.petra => const Color(0xFF1B1A65),
      WonderType.colosseum => const Color(0xFF4AA39D),
      WonderType.chichenItza => const Color(0xFFE2CFBB),
      WonderType.machuPicchu => const Color(0xFFC1D9D1),
      WonderType.tajMahal => const Color(0xFF642828),
      WonderType.christRedeemer => const Color(0xFFED7967)
    };
  }
}

extension ColorFilterOnColor on Color {
  ColorFilter get colorFilter => ColorFilter.mode(this, BlendMode.srcIn);
}
