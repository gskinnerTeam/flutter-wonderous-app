

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/controls/buttons.dart';
import 'package:wonders/ui/common/fx/fx.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/ui/common/particles/particle_field.dart';

class CollectibleFoundScreen extends StatelessWidget {
  // timing cues as durations in ms:
  static const double introDelayT = 300;
  static const double introT = 600;
  static const double detailDelayT = 0;
  static const double detailT = 1800;
  static const double startDetailT = introT + detailDelayT;
  static const double totalT = introT + detailDelayT + detailT; // don't include introDelay

  final CollectibleData collectible;
  late CachedNetworkImageProvider imageProvider;

  CollectibleFoundScreen({required this.collectible, Key? key}) : super(key: key) {
    imageProvider = CachedNetworkImageProvider(collectible.imageUrl);
  }

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
  double _subT(double t, double start, [double? duration]) {
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
    double inT = _subT(t, 0, introT * 0.8);
    double outT = _subT(t, introT);
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
    double startT = introT * 0.25; // start the particles half way through the intro
    t = _subT(t, startT);
    if (t <= 0 || t >= 1) return Container();

    Color color = context.colors.accent1;
    int particleCount = 700;
    return Positioned.fill(child: ParticleField(
      key: ValueKey('particle_field'),
      spriteSheet: SpriteSheet(
        image: AssetImage(ImagePaths.sparkle),
        frameWidth: 21,
        scale: 0.75,
      ),
      onTick: (controller, elapsed, size) {
        List<Particle> particles = controller.particles;
        int addCount = particleCount ~/ 60;
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
    )).fx.fadeOut(duration: (totalT - startT).ms, curve: Curves.easeInQuart);
  }

  Widget _buildIcon(BuildContext context, double t) {
    // keep around for the back Hero animation.
    // if (t == 1) return Container();

    double inT = _subT(t, 0, introT);
    return Center(child: _sizeFeature(Hero(
      tag: 'collectible_icon', child: Transform.scale(
        scale: 0.4 + 0.5 * inT,
        child: Image(
          image: collectible.icon,
          fit: BoxFit.contain,
        ),
      ),
    )));
  }

  Widget _buildTitles(BuildContext context, double t) {
    double inT = _subT(t, startDetailT);
    if (inT <= 0) return Container();
    return Positioned.fill(child: FractionallySizedBox(
      widthFactor: 0.7,
      alignment: Alignment.topCenter,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Gap(64.0),
        Text(collectible.title, textAlign: TextAlign.center, style: context.textStyles.h2)
          .fx.fade(delay: 900.ms, duration: detailT.ms, curve: Curves.easeOutQuad).move(begin: Offset(0, 16)),
        Gap(4.0),
        Text(collectible.period, textAlign: TextAlign.center, style: context.textStyles.title3.copyWith(color: context.colors.accent1))
          .fx.fade(delay: 600.ms, duration: detailT.ms, curve: Curves.easeOutQuad).move(begin: Offset(0, 16)),
      ],),
    ));
  }

  Widget _buildFeature(BuildContext context, double t) {
    double inT = _subT(t, startDetailT);
    if (inT <= 0) return Container();
    return Center(child: _sizeFeature(Stack(children: [
      Hero(tag: 'collectible_image', child: Transform.scale(
        scale: 0.9 + 0.1 * inT,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover, opacity: min(1, inT*2)),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(1000),
            ),
            boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(inT),
              offset: Offset(0, 12),
              blurRadius: 32,
            )]
          )
        ),
      ),),
      Positioned(
        left: 0, right: 0, bottom: 0,
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.accent1,
            boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(inT * 0.5),
              offset: Offset(0, 4),
              blurRadius: 8,
            )]
          ),
          padding: EdgeInsets.all(4),
          child: Text(
            'ARTIFACT FOUND',
            textAlign: TextAlign.center,
            style: context.textStyles.body4.copyWith(color: Colors.white, height: 1.2)
          ),
        )
      ).fx
        .move(delay: 300.ms, duration: detailT.ms, begin: Offset(0, 12), curve: Curves.easeOut)
        .scale(begin: 1.0, end: 1.1)
        .fade(duration: (detailT*0.5).ms),
    ],)));
  }

  Widget _buildButtons(BuildContext context, double t) {
    t = _subT(t, startDetailT);
    if (t <= 0) return Container();
    return Positioned.fill(child: FractionallySizedBox(
      widthFactor: 0.6,
      heightFactor: 1,
      alignment: Alignment.bottomCenter,
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        AppBtn(
          onPressed: () => print('pressed'),
          child: Text('View in my collection', textAlign: TextAlign.center, style: context.textStyles.body1),
        ).fx.fade(delay: 600.ms, duration: detailT.ms, curve: Curves.easeOutQuad).move(begin: Offset(0, -16)),
        Gap(16.0),
        AppBtn(
          onPressed: () => Navigator.pop(context),
          child: Text('close', textAlign: TextAlign.center, style: context.textStyles.body1),
        ).fx.fade(delay: 900.ms, duration: detailT.ms, curve: Curves.easeOutQuad).move(begin: Offset(0, -16)),
        Gap(32.0),
      ],),
    ));;
  }


  Widget _sizeFeature(Widget child, [double pad=0]) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.4,
      child: Center(child: AspectRatio(
        aspectRatio: 2/3,
        child: child,
      ),),
    );
  }

}