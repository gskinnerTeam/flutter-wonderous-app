

import 'dart:ui';

import 'package:wonders/common_libs.dart';
import 'package:wonders/fx/fx.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/particles/particle_field.dart';
import 'package:wonders/particles/sprite_sheet.dart';

import '../../../particles/particle.dart';

class CollectibleFoundScreen extends StatelessWidget {
  final CollectibleData collectible;

  const CollectibleFoundScreen({required this.collectible, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // todo: should this whole thing be wrapped in a RepaintBoundary?
    return FXBuilder(
      delay: 400.milliseconds,
      duration: 300.milliseconds,
      builder: (ctx, t, _) => Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(t * t * 0.5),
                Colors.black.withOpacity(t * 0.66),
              ],
              stops: [
                0,
                t*t*t*0.55,
                0.2+ t*0.7,
              ],
            )
          ),
        ),
        if (t > 0.6) Positioned.fill(child: _buildParticleField()),
        Center(child: Hero(tag: 'collectible', child: _buildImage(128 + 128 * t))),
      ],)
    );
  }

  Widget _buildGradient(double innerOpacity, double outerOpacity, double innerStop, double outerStop) {
    return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.black.withOpacity(innerOpacity),
                Colors.black.withOpacity(outerOpacity)
              ],
              stops: [innerStop, outerStop],
            )
          ),
        );
  }

  Widget _buildParticleField() {
    return ParticleField(
      spriteSheet: SpriteSheet(
        image: AssetImage('assets/images/collectibles/sparkle_21x23.png'),
        frameWidth: 21,
        scale: 0.5,
      ),
      onTick: (controller, elapsed, size) {
        List<Particle> particles = controller.particles;
        int addCount = min(20, 500 - particles.length);
        double s = min(size.width, size.height) * rnd(0.25, 0.4);
        double v = s * 0.03;
        while (--addCount > 0) {
          double angle = rnd.getRad();
          particles.add(Particle(
            x: cos(angle) * s,
            y: sin(angle) * s,
            vx: cos(angle) * v * rnd(0.3, 1),
            vy: sin(angle) * v * rnd(0.3, 1),
            lifespan: rnd(30, 60),
          ));
        }
        for (int i = particles.length-1; i >= 0; i--) {
          Particle o = particles[i];
          if (o.age >= o.lifespan) { particles.removeAt(i); continue; }
          o.update(
            frame: o.age ~/ 3,
            vy: o.vy + 0.1, // gravity
            color: Colors.white.withOpacity(pow(1-o.age/o.lifespan, 2).toDouble()),
          );
        }
      }
    );
  }

  Widget _buildImage([double size=64.0]) {
    return Image(
      image: collectible.sillhouette,
      width: size, height: size,
      fit: BoxFit.contain,
    );
  }
}