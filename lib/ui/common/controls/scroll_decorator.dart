import 'package:wonders/common_libs.dart';

// todo: clean up, doc, and package
class ScrollDecorator extends StatefulWidget {
  ScrollDecorator({Key? key, required this.builder, this.foregroundBuilder, this.backgroundBuilder, this.controller})
      : super(key: key);

  ScrollDecorator.fade({
    Key? key,
    required this.builder,
    this.controller,
    Widget? begin,
    Widget? end,
    bool background = false,
    Axis direction = Axis.vertical,
    Duration duration = const Duration(milliseconds: 150),
  }) : super(key: key) {
    // ignore: prefer_function_declarations_over_variables
    ScrollBuilder builder = (controller) => Flex(
          direction: direction,
          children: [
            if (begin != null)
              AnimatedOpacity(
                duration: duration,
                opacity: controller.hasClients && controller.position.extentBefore > 3 ? 1 : 0,
                child: begin,
              ),
            Spacer(),
            if (end != null)
              AnimatedOpacity(
                duration: duration,
                opacity: controller.hasClients && controller.position.extentAfter > 3 ? 1 : 0,
                child: end,
              ),
          ],
        );
    backgroundBuilder = background ? builder : null;
    foregroundBuilder = !background ? builder : null;
  }

  
  ScrollDecorator.shadow({Key? key, required this.builder, this.controller, double opacity = 0.5}) : super(key: key) {
    backgroundBuilder = null;
    foregroundBuilder = (controller) {
      final double ratio = controller.hasClients ? min(1, controller.position.extentBefore / 60) : 0;
      return IgnorePointer(
        child: Container(
          height: 24,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(ratio * opacity), Colors.transparent],
              stops: [0, ratio],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      );
    };
  }

  final ScrollController? controller;
  final ScrollBuilder builder;
  late final ScrollBuilder? foregroundBuilder;
  late final ScrollBuilder? backgroundBuilder;

  @override
  State<ScrollDecorator> createState() => _ScrollDecoratorState();
}

class _ScrollDecoratorState extends State<ScrollDecorator> {
  ScrollController? _controller;
  late Widget content;

  @override
  void initState() {
    if (widget.controller == null) _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController controller = (widget.controller ?? _controller)!;

    content = widget.builder(controller);
    return AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return Stack(
            children: [
              if (widget.backgroundBuilder != null) widget.backgroundBuilder!(controller),
              content,
              if (widget.foregroundBuilder != null) widget.foregroundBuilder!(controller),
            ],
          );
        });
  }
}

typedef ScrollBuilder = Widget Function(ScrollController controller);