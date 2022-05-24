import 'package:wonders/common_libs.dart';

class FadeFromColor extends StatefulWidget {
  const FadeFromColor({Key? key, this.color, required this.child, this.delay}) : super(key: key);

  final Widget child;
  final Color? color;
  final Duration? delay;

  @override
  State<FadeFromColor> createState() => _FadeFromColorState();
}

class _FadeFromColorState extends State<FadeFromColor> {
  bool _hideOverlay = false;

  void _handleFadeComplete(AnimationController controller) {
    setState(() => _hideOverlay = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_hideOverlay) return widget.child;
    return Stack(
      children: [
        //widget.child,
        ColoredBox(color: widget.color ?? context.colors.black)
            .animate(onComplete: _handleFadeComplete)
            .fadeOut(delay: widget.delay)
      ],
    );
  }
}
