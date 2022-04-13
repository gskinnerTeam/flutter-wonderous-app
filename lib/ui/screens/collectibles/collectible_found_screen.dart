

import 'dart:ui';

import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fx/fx.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/ui/common/particles/particle_field.dart';

class CollectibleFoundScreen extends StatelessWidget {
  // timing cues as durations in ms:
  static const double introDelayT = 200;
  static const double introT = 500;
  static const double detailDelayT = 800;
  static const double detailT = 800;
  static const double totalT = introT + detailDelayT + detailT; // don't include introDelay

  final CollectibleData collectible;

  const CollectibleFoundScreen({required this.collectible, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // todo: should this whole thing be wrapped in a RepaintBoundary?
    return FXBuilder(
      delay: introDelayT.ms,
      duration: totalT.ms,
      builder: (ctx, t, _) => Stack(children: [
        _buildBlur(context, t),
        _buildGradient(context, t),
        _buildParticleField(context, t),
        _buildIcon(context, t),
        _buildTitles(context, t),
        _buildFeature(context, t),
        _buildButtons(context, t),
      ]),
    );
  }

  // returns a new ratio (0-1) normalized within the time period specified by start and duration
  double _getT(double t, double start, [double? duration]) {
    double end = duration == null ? totalT : start + duration;
    return max(0, min(1, (t * totalT - start)/(end - start)));
  }

  Widget _buildBlur(BuildContext context, double t) {
    double blur = t * 10;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(),
    );
  }

  Widget _buildGradient(BuildContext context, double t) {
    double inT = _getT(t, 0, introT * 0.8);
    double outT = _getT(t, introT);
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Colors.black.withOpacity(0 + outT * 0.7),
            Colors.black.withOpacity(inT * 0.6 + outT * 0.2),
          ],
          stops: [
            0.1,
            0.5 + inT * 0.4 + outT * 0.1,
          ],
        )
      ),
    );
  }

  Widget _buildParticleField(BuildContext context, double t) {
    double startT = introT * 0.5; // start the particles half way through the intro
    t = _getT(t, startT);
    if (t <= 0 || t >= 1) return Container();

    Color color = context.colors.accent1;
    int particleCount = 500;
    return Positioned.fill(child: ParticleField(
      key: ValueKey('particle_field'),
      spriteSheet: SpriteSheet(
        image: AssetImage('assets/images/collectibles/sparkle_21x23.png'),
        frameWidth: 21,
        scale: 0.5,
      ),
      onTick: (controller, elapsed, size) {
        List<Particle> particles = controller.particles;
        int addCount = particleCount ~/ 30;
        particleCount -= addCount;
        double d = min(size.width, size.height) * rnd(0.25, 0.3);
        double v = d * 0.08;
        while (--addCount > 0) {
          double angle = rnd.getRad();
          particles.add(Particle(
            x: cos(angle) * d,
            y: sin(angle) * d,
            vx: cos(angle) * v * rnd(0.5, 1),
            vy: sin(angle) * v * rnd(0.5, 1),
            color: color.withOpacity(rnd(0.6, 1)),
          ));
        }
        for (int i = particles.length-1; i >= 0; i--) {
          Particle o = particles[i];
          o.update(frame: o.age ~/ 3, );
          if (o.age > 50) particles.removeAt(i);
        }
      }
    )).fx.fadeOut(duration: (totalT - startT).ms);
  }

  Widget _buildIcon(BuildContext context, double t) {
    if (t == 1) return Container();

    double inT = _getT(t, 100, introT);
    return Center(child: _sizeFeature(Hero(
      tag: 'collectible', child: Transform.scale(
        scale: 0.4 + 0.6 * inT,
        child: Image(
          image: collectible.icon,
          fit: BoxFit.contain,
        ),
      ),
    )));
  }

  Widget _buildTitles(BuildContext context, double t) {
    return Container();
  }

  Widget _buildFeature(BuildContext context, double t) {
    return Container();
  }

  Widget _buildButtons(BuildContext context, double t) {
    return Container();
  }


  Widget _sizeFeature(Widget child, [double t = 1]) {
    return FractionallySizedBox(
      widthFactor: 0.4 * t,
      heightFactor: 0.4 * t,
      child: child,
    );
  }

}