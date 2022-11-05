import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:wonders/logic/common/platform_info.dart';

/// Add mouse drag on desktop for easier responsive testing
class AppScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices {
    return Set.from(super.dragDevices)..add(PointerDeviceKind.mouse);
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const BouncingScrollPhysics();

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
    return PlatformInfo.isAndroid
        ? RawScrollbar(controller: details.controller, child: child)
        : CupertinoScrollbar(controller: details.controller, child: child);
  }
}
