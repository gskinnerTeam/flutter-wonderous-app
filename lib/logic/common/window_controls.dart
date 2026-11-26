import 'package:flutter/foundation.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';

/// Left inset taken by the iPadOS 26+ window controls in a resizable window.
/// Flutter's safe area doesn't include them, so the native side reports it (see ios/Runner/AppDelegate.swift).
class WindowControls {
  static final leftInset = ValueNotifier<double>(0);
  static const _channel = MethodChannel('wonderous/window_controls');

  static void init() {
    if (kIsWeb || !PlatformInfo.isIOS) return;
    _channel.setMethodCallHandler((call) async => leftInset.value = call.arguments as double);
    _channel.invokeMethod<double>('getInset').then((v) => leftInset.value = v ?? 0);
  }
}

/// Shifts [child] right to clear the iPadOS window controls. Adds no space when they aren't shown.
class WindowControlsPadding extends StatelessWidget {
  const WindowControlsPadding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: WindowControls.leftInset,
      builder: (_, inset, child) => Padding(
        // Next to the window controls, use a tighter gap than at a screen edge (xs instead of the usual sm).
        padding: EdgeInsets.only(left: inset > 0 ? inset - $styles.insets.xs : 0),
        child: child,
      ),
      child: child,
    );
  }
}
