part of '../collectible_found_screen.dart';

class _CelebrationParticles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color color = context.colors.accent1;
    int particleCount = 800;
    return Positioned.fill(
      child: ParticleField(
        spriteSheet: SpriteSheet(
          image: AssetImage(ImagePaths.sparkle),
          frameWidth: 21,
          scale: 0.75,
        ),
        onTick: (controller, elapsed, size) {
          List<Particle> particles = controller.particles;
          // calculate base distance from center & velocity:
          final double d = min(size.width, size.height) * 0.3;
          final double v = d * 0.08;
          // add new particles, reducing the number added each tick:
          int addCount = particleCount ~/ 40;
          particleCount -= addCount;
          while (--addCount > 0) {
            double angle = rnd.getRad();
            particles.add(Particle(
              // adding random variation makes it more visually interesting:
              x: cos(angle) * d * rnd(0.8, 1),
              y: sin(angle) * d * rnd(0.8, 1),
              vx: cos(angle) * v * rnd(0.5, 1.5),
              vy: sin(angle) * v * rnd(0.5, 1.5),
              color: color.withOpacity(rnd(0.5, 1)),
            ));
          }
          // update existing particles & remove old ones:
          for (int i = particles.length - 1; i >= 0; i--) {
            Particle o = particles[i];
            o.update(frame: o.age ~/ 3);
            if (o.age > 40) particles.removeAt(i);
          }
        },
      ).fx().fadeOut(duration: CollectibleFoundScreen.detailT.ms, curve: Curves.easeIn),
    );
  }
}
