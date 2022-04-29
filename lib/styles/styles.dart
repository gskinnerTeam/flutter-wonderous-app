import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';
import 'package:wonders/styles/corners.dart';
import 'package:wonders/styles/insets.dart';
import 'package:wonders/styles/text.dart';
import 'package:wonders/styles/times.dart';

export 'colors.dart';

class AppStyle {
  AppStyle({required this.screenSize}) {
    scale = _calculateScale(screenSize);
    debugPrint('appStyle.scale=$scale');
  }

  /// The current theme colors for the app
  final AppColors colors = AppColors();

  /// Rounded edge corner radii
  late final AppCorners corners = AppCorners();

  /// Padding and margin values
  late final AppInsets insets = AppInsets(scale);

  /// Text styles
  late final AppTextStyles text = AppTextStyles(scale);

  /// Animation Durations
  final AppTimes times = AppTimes();

  /// The app screen size, from which we can calculate padding and text scaling values.
  late final Size screenSize;

  /// Scale values allows us to generally adjust font sizes and padding values for different form factors
  /// eg, -10% on very small phones, or +25% on larger touch devices.
  late final double scale;

  /// Scale text down a little on smaller devices, and up slightly on larger ones
  double _calculateScale(Size size) {
    if (PlatformInfo.isDesktop) return 1;
    final diagonalPx = (size.shortestSide + size.longestSide) / 2;
    return .85 + diagonalPx / 3000;
  }
}

extension StyleContextExtension on BuildContext {
  AppStyle get style => watch<AppStyle>();
  AppInsets get insets => style.insets;
  AppTextStyles get textStyles => style.text;
  AppColors get colors => style.colors;
  AppTimes get times => style.times;
  AppTextStyles get text => style.text;
  AppCorners get corners => style.corners;
}
