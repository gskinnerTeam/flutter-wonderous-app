import 'package:flutter/material.dart';

class ContextUtils {
  static Offset? getGlobalPos(BuildContext context, [Offset offset = Offset.zero]) {
    final rb = context.findRenderObject() as RenderBox?;
    if (rb?.hasSize == true) {
      return rb?.localToGlobal(offset);
    }
    return null;
  }

  static Size? getSize(BuildContext context) {
    final rb = context.findRenderObject() as RenderBox?;
    if (rb?.hasSize == true) {
      return rb?.size;
    }
    return null;
  }
}
