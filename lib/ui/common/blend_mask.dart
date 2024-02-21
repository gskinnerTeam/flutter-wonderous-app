import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class BlendMask extends SingleChildRenderObjectWidget {
  final List<BlendMode> blendModes;
  final double opacity;

  const BlendMask({required this.blendModes, this.opacity = 1.0, super.key, required Widget super.child});

  @override
  RenderObject createRenderObject(context) => RenderBlendMask(blendModes, opacity);

  @override
  void updateRenderObject(BuildContext context, RenderBlendMask renderObject) {
    renderObject.blendModes = blendModes;
    renderObject.opacity = opacity;
  }
}

class RenderBlendMask extends RenderProxyBox {
  List<BlendMode> blendModes;
  double opacity;

  RenderBlendMask(this.blendModes, this.opacity);

  @override
  void paint(context, offset) {
    // Complex blend modes can be raster cached incorrectly on the Skia backend.
    context.setWillChangeHint();
    for (var blend in blendModes) {
      context.canvas.saveLayer(
        offset & size,
        Paint()
          ..blendMode = blend
          ..color = Color.fromARGB((opacity * 255).round(), 255, 255, 255),
      );
    }
    super.paint(context, offset);
    context.canvas.restore();
  }
}
