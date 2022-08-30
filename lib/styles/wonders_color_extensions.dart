import 'package:wonders/common_libs.dart';

extension WonderColorExtensions on WonderType {
  Color get bgColor {
    switch (this) {
      case WonderType.pyramidsGiza:
        return const Color(0xFF16184D);
      case WonderType.greatWall:
        return const Color(0xFF642828);
      case WonderType.petra:
        return const Color(0xFF444B9B);
      case WonderType.colosseum:
        return const Color(0xFF1E736D);
      case WonderType.chichenItza:
        return const Color(0xFF164F2A);
      case WonderType.machuPicchu:
        return const Color(0xFF0E4064);
      case WonderType.tajMahal:
        return const Color(0xFFC96454);
      case WonderType.christRedeemer:
        return const Color(0xFF1C4D46);
    }
  }

  Color get fgColor {
    switch (this) {
      case WonderType.pyramidsGiza:
        return const Color(0xFF444B9B);
      case WonderType.greatWall:
        return const Color(0xFF688750);
      case WonderType.petra:
        return const Color(0xFF1B1A65);
      case WonderType.colosseum:
        return const Color(0xFF4AA39D);
      case WonderType.chichenItza:
        return const Color(0xFFE2CFBB);
      case WonderType.machuPicchu:
        return const Color(0xFFC1D9D1);
      case WonderType.tajMahal:
        return const Color(0xFF642828);
      case WonderType.christRedeemer:
        return const Color(0xFFED7967);
    }
  }
}
