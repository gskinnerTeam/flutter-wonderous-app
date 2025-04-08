import 'package:wonders/common_libs.dart';

extension DurationExtensions on int {
  Duration get delayMs => $styles.disableAnimations ? 0.ms : Duration(milliseconds: this);
  Duration get animateMs => $styles.disableAnimations ? 1.ms : Duration(milliseconds: this);
}