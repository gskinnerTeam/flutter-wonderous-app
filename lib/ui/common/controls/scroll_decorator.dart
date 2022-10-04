import 'dart:math';

import 'package:flutter/material.dart';

/// Easily add visual decorations to a scrolling widget based on the state of its controller.
class ScrollDecorator extends StatefulWidget {
  /// Creates a widget that builds foreground and/or background decorations for a scrolling widget based on the state of
  /// its ScrollController.
  // ignore: prefer_const_constructors_in_immutables
  ScrollDecorator({
    Key? key,
    required this.builder,
    this.fgBuilder,
    this.bgBuilder,
    this.controller,
    this.onInit,
  }) : super(key: key);

  /// Creates a ScrollDecorator that fades a widget in at the begin or end of the scrolling widget based on the scroll
  /// position. For example on a vertical list, it would fade in the `begin` widget when the list is not scrolled to the
  /// top.
  ScrollDecorator.fade({
    Key? key,
    required this.builder,
    this.controller,
    this.onInit,
    Widget? begin,
    Widget? end,
    bool bg = false,
    Axis direction = Axis.vertical,
    Duration duration = const Duration(milliseconds: 150),
  }) : super(key: key) {
    Flex flexBuilder(controller) {
      return Flex(
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
    }

    bgBuilder = bg ? flexBuilder : null;
    fgBuilder = !bg ? flexBuilder : null;
  }

  /// Creates an ScrollDecorator that adds a shadow to the top of a vertical list when it is scrolled down.
  ScrollDecorator.shadow({
    Key? key,
    required this.builder,
    this.controller,
    this.onInit,
    Color color = Colors.black54,
  }) : super(key: key) {
    bgBuilder = null;
    fgBuilder = (controller) {
      final double ratio = controller.hasClients ? min(1, controller.position.extentBefore / 60) : 0;
      return IgnorePointer(
        child: Container(
          height: 24,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(ratio * color.opacity), Colors.transparent],
              stops: [0, ratio],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      );
    };
  }

  /// The ScrollController to use when building the scrolling widget. If null, a ScrollController will be created
  /// automatically.
  final ScrollController? controller;

  /// Builder to create the scrolling widget. It should use the ScrollController that is provided to the builder.
  final ScrollBuilder builder;

  /// Builder to create the decoration widget that will be layered in front of the scrolling widget. It should use the
  /// provided ScrollController to adjust its output as appropriate.
  late final ScrollBuilder? fgBuilder;

  /// Builder to create the decoration widget that will be layered behind the scrolling widget. It should use the
  /// provided ScrollController to adjust its output as appropriate.
  late final ScrollBuilder? bgBuilder;

  final void Function(ScrollController controller)? onInit;

  @override
  State<ScrollDecorator> createState() => _ScrollDecoratorState();
}

class _ScrollDecoratorState extends State<ScrollDecorator> {
  ScrollController? _controller;
  late Widget content;

  ScrollController get currentController => (widget.controller ?? _controller)!;

  @override
  void initState() {
    if (widget.controller == null) _controller = ScrollController();
    widget.onInit?.call(currentController);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    content = widget.builder(currentController);
    return AnimatedBuilder(
        animation: currentController,
        builder: (_, __) {
          return Stack(
            children: [
              if (widget.bgBuilder != null) ...[
                widget.bgBuilder!(currentController),
              ],
              content,
              if (widget.fgBuilder != null) ...[
                widget.fgBuilder!(currentController),
              ],
            ],
          );
        });
  }
}

/// Builder function type for use with ScrollDecorator.
typedef ScrollBuilder = Widget Function(ScrollController controller);
