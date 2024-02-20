import 'package:wonders/common_libs.dart';

class ArrowDir {
  ArrowDir(this.hz, this.vt);
  int hz;
  int vt;

  bool get isNotZero => hz != 0 || vt != 0;
}

class KeyboardArrowsListener extends StatefulWidget {
  const KeyboardArrowsListener({super.key, required this.child, required this.onArrow});
  final Widget child;
  final void Function(ArrowDir dir) onArrow;
  @override
  State<KeyboardArrowsListener> createState() => _KeyboardArrowsListenerState();
}

class _KeyboardArrowsListenerState extends State<KeyboardArrowsListener> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: _focusNode,
      onKey: _handleKey,
      child: widget.child,
    );
  }

  void _handleKey(RawKeyEvent event) {
    if (event is! RawKeyDownEvent) return;
    if (event.repeat) return;
    final arrowDir = ArrowDir(0, 0);
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      arrowDir.hz = -1;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      arrowDir.hz = 1;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      arrowDir.vt = 1;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      arrowDir.vt = -1;
    }
    if (arrowDir.isNotZero) {
      widget.onArrow(arrowDir);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
