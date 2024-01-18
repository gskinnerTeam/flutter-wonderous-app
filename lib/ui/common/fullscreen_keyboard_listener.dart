import 'package:wonders/common_libs.dart';

class FullscreenKeyboardListener extends StatefulWidget {
  const FullscreenKeyboardListener({super.key, required this.child, this.onKeyDown, this.onKeyUp, this.onKeyRepeat});
  final Widget child;
  final bool Function(KeyDownEvent event)? onKeyDown;
  final bool Function(KeyUpEvent event)? onKeyUp;
  final bool Function(KeyRepeatEvent event)? onKeyRepeat;

  @override
  State<FullscreenKeyboardListener> createState() => _FullscreenKeyboardListenerState();
}

class _FullscreenKeyboardListenerState extends State<FullscreenKeyboardListener> {
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

    /// Exit early if we are not the current;y focused route (dialog on top?)
    if (ModalRoute.of(context)?.isCurrent == false) return false;

    if (event is KeyDownEvent && widget.onKeyDown != null) {
      result = widget.onKeyDown!.call(event);
    }
    if (event is KeyUpEvent && widget.onKeyUp != null) {
      result = widget.onKeyUp!.call(event);
    }
    if (event is KeyRepeatEvent && widget.onKeyRepeat != null) {
      result = widget.onKeyRepeat!.call(event);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
