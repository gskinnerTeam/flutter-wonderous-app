import 'package:flutter/rendering.dart';
import 'package:wonders/common_libs.dart';

class IgnorePointerWithSemantics extends SingleChildRenderObjectWidget {
  const IgnorePointerWithSemantics({super.key, super.child});

  @override
  RenderIgnorePointerWithSemantics createRenderObject(BuildContext context) {
    return RenderIgnorePointerWithSemantics();
  }
}

class RenderIgnorePointerWithSemantics extends RenderProxyBox {
  RenderIgnorePointerWithSemantics();

  @override
  bool hitTest(BoxHitTestResult result, { required Offset position }) => false;
}