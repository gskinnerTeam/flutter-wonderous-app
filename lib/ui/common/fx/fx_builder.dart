import 'package:flutter/widgets.dart';
import 'package:wonders/ui/common/fx/fx.dart';

// FXBuilder simplifies working with AnimatedBuilder, especially in
// StatelessWidgets. It handles the creation and disposal of the controller,
// and passes the current animation value through to the builder function.
class FXBuilder extends StatefulWidget {
  // TODO: GDS: add begin/end and typed builders?
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final Widget? child;
  final FXBuilderBuilder builder;

  const FXBuilder(
      {required this.builder,
      required this.duration,
      this.delay = Duration.zero,
      this.curve = Curves.linear,
      this.child,
      Key? key})
      : super(key: key);

  @override
  State<FXBuilder> createState() => _FXBuilderState();
}

class _FXBuilderState extends State<FXBuilder> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Duration begin = widget.delay, end = begin + widget.duration;
    _controller.duration = end;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    Duration begin = widget.delay, end = begin + widget.duration;
    Animation<double> animation = buildSubAnimation(_controller, begin, end, widget.curve);
    return AnimatedBuilder(
      animation: animation,
      child: widget.child,
      builder: (ctx, child) => widget.builder(ctx, animation.value, child),
    );
  }
}

// yes, this name is silly.
typedef FXBuilderBuilder = Widget Function(BuildContext context, double ratio, Widget? child);
