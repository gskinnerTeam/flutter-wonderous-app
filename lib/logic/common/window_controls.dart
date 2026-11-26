import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';

/// Tracks the left inset taken by iPadOS 26 window controls (close/minimize/zoom) in resizable windows.
/// The value is provided natively, as Flutter does not expose it through MediaQuery.
class WindowControls {
  static final ValueNotifier<double> leftInset = ValueNotifier(0);
  static const _channel = MethodChannel('wonderous/window_controls');

  static Future<void> init() async {
    if (!PlatformInfo.isIOS) return;
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'insetsChanged') {
        leftInset.value = _readLeft(call.arguments);
      }
    });
    try {
      leftInset.value = _readLeft(await _channel.invokeMethod('getInsets'));
    } on PlatformException {
      // Ignore, inset stays 0.
    } on MissingPluginException {
      // Ignore, inset stays 0.
    }
  }

  static double _readLeft(dynamic args) => args is Map ? ((args['left'] as num?)?.toDouble() ?? 0) : 0;
}

/// Pads [child] on the left to clear the iPadOS window controls. Returns [child] unchanged when there is no inset.
class WindowControlsPadding extends StatelessWidget {
  const WindowControlsPadding({super.key, required this.child, this.enabled = true});

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;
    return ValueListenableBuilder<double>(
      valueListenable: WindowControls.leftInset,
      builder: (_, inset, child) {
        if (inset == 0) return child!;
        return Padding(
          padding: EdgeInsets.only(left: inset),
          child: child,
        );
      },
      child: child,
    );
  }
}
