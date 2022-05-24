import 'package:wonders/common_libs.dart';

class FadeFromColor extends StatefulWidget {
  const FadeFromColor({Key? key, this.color, required this.child}) : super(key: key);

  final Widget child;
  final Color? color;

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
        widget.child,
        Animate(
          effects: const [FadeEffect(begin: 1, end: 0)],
          onComplete: _handleFadeComplete,
          child: ColoredBox(color: widget.color ?? context.colors.black),
        )
      ],
    );
  }
}
