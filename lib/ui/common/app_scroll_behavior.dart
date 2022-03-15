import 'package:flutter/gestures.dart';
import 'package:wonders/common_libs.dart';

/// Add mouse drag on desktop for easier responsive testing
class AppScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices {
    return Set.from(super.dragDevices)..add(PointerDeviceKind.mouse);
  }
}
