import 'package:flutter/material.dart';

class ContextUtils {
  static Offset? getGlobalPos(BuildContext context, [Offset offset = Offset.zero]) {
    final rb = context.findRenderObject() as RenderBox?;
    try {
      if (rb?.hasSize == true && rb?.attached == true) {
        return rb?.localToGlobal(offset);
      }
    } catch (e) {
      // localToGlobal can throw if the render box is in the process of being removed from the tree
      debugPrint('Error getting global position: $e');
    }
    return null;
  }

  static Size? getSize(BuildContext context) {
    final rb = context.findRenderObject() as RenderBox?;
    try {
      if (rb?.hasSize == true && rb?.attached == true) {
        return rb?.size;
      }
    } catch (e) {
      // localToGlobal can throw if the render box is in the process of being removed from the tree
      debugPrint('Error getting size: $e');
    }
    return null;
  }
}
