import 'package:flutter/material.dart';

class ContextUtils {
  static Offset? getGlobalPos(BuildContext context, [Offset offset = Offset.zero]) {
    final rb = context.findRenderObject() as RenderBox?;
    return rb?.localToGlobal(offset);
  }

  static Size? getSize(BuildContext context) {
    final rb = context.findRenderObject() as RenderBox?;
    return rb?.size;
  }
}
