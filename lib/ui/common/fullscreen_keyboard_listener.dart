import 'package:wonders/common_libs.dart';

class FullScreenKeyboardListener extends StatefulWidget {
  const FullScreenKeyboardListener({super.key, required this.child, this.onKeyDown, this.onKeyUp});
  final Widget child;
  final bool Function(KeyDownEvent event)? onKeyDown;
  final bool Function(KeyUpEvent event)? onKeyUp;

  @override
  State<FullScreenKeyboardListener> createState() => _FullScreenKeyboardListenerState();
}

class _FullScreenKeyboardListenerState extends State<FullScreenKeyboardListener> {
  @override
  void initState() {
    super.initState();
    ServicesBinding.instance.keyboard.addHandler(_handleKey);
  }

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(_handleKey);
    super.dispose();
  }

  bool _handleKey(KeyEvent event) {
    bool result = false;
    if (event is KeyDownEvent && widget.onKeyDown != null) {
      result = widget.onKeyDown!.call(event);
    }
    if (event is KeyUpEvent && widget.onKeyUp != null) {
      result = widget.onKeyUp!.call(event);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
