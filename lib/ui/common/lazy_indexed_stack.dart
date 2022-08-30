import 'package:flutter/material.dart';

/// A lazy-loading [IndexedStack] that loads [children] accordingly.
class LazyIndexedStack extends StatefulWidget {
  const LazyIndexedStack({
    Key? key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
    this.index = 0,
    this.children = const [],
  }) : super(key: key);

  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final StackFit sizing;
  final int index;
  final List<Widget> children;

  @override
  LazyIndexedStackState createState() => LazyIndexedStackState();
}

class LazyIndexedStackState extends State<LazyIndexedStack> {
  late List<bool> _activated = _initializeActivatedList();

  List<bool> _initializeActivatedList() => List<bool>.generate(widget.children.length, (i) => i == widget.index);

  @override
  void didUpdateWidget(covariant LazyIndexedStack oldWidget) {
    if (oldWidget.children.length != widget.children.length) {
      _activated = _initializeActivatedList();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // Mark current index as active
    _activated[widget.index] = true;
    final children = List.generate(_activated.length, (i) {
      return _activated[i] ? widget.children[i] : const SizedBox.shrink();
    });
    return IndexedStack(
      alignment: widget.alignment,
      sizing: widget.sizing,
      textDirection: widget.textDirection,
      index: widget.index,
      children: children,
    );
  }
}
