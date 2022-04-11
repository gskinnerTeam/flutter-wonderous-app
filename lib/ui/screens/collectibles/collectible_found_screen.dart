

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
        if (t > 0.6) Positioned.fill(child: ParticleField(
          spriteSheet: SpriteSheet(
            image: AssetImage('assets/images/collectibles/sparkle_21x23.png'),
            frameWidth: 21
          ),
          onTick: (controller, elapsed, size) {
            List<Particle> particles = controller.particles;
            int addCount = min(5, 120 - particles.length);
            double s = min(size.width, size.height) * rnd(0.3, 0.4);
            double v = s * 0.08;
            while (--addCount > 0) {
              double angle = rnd.getRad();
              particles.add(StarParticle(
                x: cos(angle) * s,
                y: sin(angle) * s,
                vx: cos(angle) * v * rnd(0.3, 1),
                vy: sin(angle) * v * rnd(0.3, 1),
                life: rnd(0.1, 1),
              ));
            }
            for (int i = particles.length-1; i >= 0; i--) {
              StarParticle o = particles[i] as StarParticle;
              o.life -= 0.015;
              if (o.life <= 0) { particles.removeAt(i); continue; }
              o.x += o.vx;
              o.y += o.vy;
              o.color = Colors.white.withOpacity(o.life * o.life);
              o.frame = (o.frame + 1) % controller.spriteSheet.length;
            }
          }
        ),),
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

  Widget _buildImage([double size=64.0]) {
    return Image(
      image: collectible.sillhouette,
      width: size, height: size,
      fit: BoxFit.contain,
    );
  }
}

class StarParticle extends Particle {
  double vx;
  double vy;
  double life;

  StarParticle({x, y, this.vx=0, this.vy=0, this.life=1}) {
    this.x = x;
    this.y = y;
    scale = 0.66;
  }
} 