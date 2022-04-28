import 'package:flutter/material.dart';
import 'package:wonders/ui/common/particles/particle_field.dart';

// Renders a ParticleField.
class ParticleFieldPainter extends CustomPainter {
  final ParticleController controller;

  // ParticleField is a ChangeNotifier, so we can use it as the repaint notifier.
  ParticleFieldPainter({
    required this.controller,
  }) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    List<Particle> particles = controller.particles;
    controller.executeOnTick(size);
    int l = particles.length;
    if (l == 0) return; // no particles

    SpriteSheet spriteSheet = controller.spriteSheet;
    if (spriteSheet.image == null) return; // image hasn't loaded

    Paint fill = Paint();
    List<RSTransform> transforms = [];
    List<Rect> rects = [];
    List<Color> colors = [];

    Alignment alignment = Alignment.center;
    double xOffset = size.width / 2 * (alignment.x + 1);
    double yOffset = size.height / 2 * (alignment.y + 1);
    double spriteScale = spriteSheet.scale;

    double opacity = controller.opacity;

    for (int i = 0; i < l; i++) {
      Particle o = particles[i];

      // Each particle has a transformation entry, which tells drawAtlas where to draw it.
      transforms.add(RSTransform.fromComponents(
          translateX: o.x + xOffset,
          translateY: o.y + yOffset,
          rotation: o.rotation,
          scale: o.scale * spriteScale,
          anchorX: 0,
          anchorY: 0));

      // Add a rect entry, which describes the portion (frame) of the sprite sheet image to use as the source.
      rects.add(spriteSheet.getFrame(o.frame));

      // Add a color entry, which is composited with the frame via the blend mode.
      colors.add(o.color.withOpacity(o.color.opacity * opacity));
    }

    // Draw all of the particles based on the data entries.
    canvas.drawAtlas(
      spriteSheet.image!,
      transforms,
      rects,
      colors,
      controller.blendMode,
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      fill,
    );
  }

  @override
  bool shouldRepaint(oldDelegate) => true;
}
