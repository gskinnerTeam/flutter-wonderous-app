import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/measurable_widget.dart';

class OpeningBox extends StatefulWidget {
  const OpeningBox(
      {Key? key,
      required this.closedBuilder,
      required this.openBuilder,
      required this.isOpen,
      this.background,
      this.padding})
      : super(key: key);

  final Widget Function(BuildContext) closedBuilder;
  final Widget Function(BuildContext) openBuilder;
  final Widget? background;
  final bool isOpen;
  final EdgeInsets? padding;

  @override
  State<OpeningBox> createState() => _OpeningBoxState();
}

class _OpeningBoxState extends State<OpeningBox> {
  Size _size = Size.zero;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Size>(
      duration: context.times.fast,
      curve: Curves.easeOut,
      builder: (_, value, child) => Stack(
        children: [
          if (widget.background != null) ...[
            Positioned.fill(child: widget.background!),
          ],
          Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: SizedBox(
              width: value.width,
              height: value.height,
              child: child,
            ),
          ),
        ],
      ),
      tween: Tween(begin: _size, end: _size),
      child: AnimatedSwitcher(
        duration: context.times.fast,
        child: ClipRect(
          key: ValueKey(widget.isOpen),
          child: UnconstrainedBox(
            child: MeasurableWidget(
              onChange: (size) {
                setState(() => _size = size);
              },
              child: widget.isOpen ? widget.openBuilder(context) : widget.closedBuilder(context),
            ),
          ),
        ),
      ),
    );
  }
}