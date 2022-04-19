import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/ui/common/particles/particle_field.dart';
import 'package:wonders/ui/screens/collectibles/widgets/animated_ribbon.dart';

// todo: maybe: title text size (2 line max): https://pub.dev/packages/auto_size_text

class CollectibleFoundScreen extends StatelessWidget {
  // CollectibleItem passes in a (theoretically) pre-loaded imageProvider.
  // we could check for load completion, and hold after introT, but that shouldn't be necessary in a real-world scenario.
  const CollectibleFoundScreen({required this.collectible, required this.imageProvider, Key? key}) : super(key: key);

  // major timing cues as durations in ms:
  static const double introT = 600; // initial build
  static const double introPauseT = 600; // visual pause between states
  static const double introTotalT = introT + introPauseT;
  static const double detailT = 1800; // detail state build
  static const double totalT = introT + introPauseT + detailT;

  final CollectibleData collectible;
  final CachedNetworkImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    // todo: should this whole thing be wrapped in a RepaintBoundary?
    return FXBuilder(
      duration: totalT.ms,
      builder: (ctx, ratio, _) => Stack(children: [
        ..._buildIntro(context, ratio),
        ..._buildDetail(context, ratio),
      ]),
    );
  }

  // returns a new ratio (0-1) normalized within the time period specified by start and duration
  double _subRatio(double ratio, double start, [double? duration]) {
    final double end = duration == null ? totalT : start + duration;
    return max(0, min(1, (ratio * totalT - start) / (end - start)));
  }

  List<Widget> _buildIntro(BuildContext context, double ratio) {
    final double introRatio = _subRatio(ratio, 0, introTotalT);
    final double introPauseRatio = _subRatio(ratio, introT, introPauseT);
    if (introRatio == 1) return [];
    return [
      // build radial gradient over initial intro:
      _buildGradient(context, introRatio, 0),
      // icon is handled by Hero initially, then scales slowly during the pause:
      _buildIcon(context, introPauseRatio),
    ];
  }

  List<Widget> _buildDetail(BuildContext context, double ratio) {
    final double detailRatio = _subRatio(ratio, introTotalT);
    if (detailRatio == 0) return [];
    return [
      // background blur:
      _buildBlur(context, detailRatio),
      // radial gradient to solid fill in first 300ms:
      _buildGradient(context, 1, _subRatio(ratio, introTotalT, 300)),
      _buildParticleField(context, detailRatio),
      // add the detail UI in a column to facilitate better responsiveness:
      SafeArea(
        child: Column(children: [
          Spacer(flex: 5),
          Flexible(flex: 18, child: Center(child: _buildImage(context, detailRatio))),
          Spacer(flex: 2),
          _buildRibbon(context, detailRatio),
          Spacer(flex: 1),
          _buildTitle(context, detailRatio),
          Spacer(flex: 1),
          _buildSubTitle(context, detailRatio),
          Spacer(flex: 3),
          _buildCollectionButton(context, detailRatio),
        ]),
      ),
      _buildCloseButton(context, detailRatio),
    ];
  }

  Widget _buildGradient(BuildContext context, double ratioIn, double ratioOut) {
    const double opacity = 0.77;
    final Color color = context.colors.black;

    // final state is a solid fill, so optimize for that:
    if (ratioOut == 1) return Container(color: color.withOpacity(opacity));

    ratioIn = Curves.easeOutQuint.transform(ratioIn);
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            color.withOpacity(opacity * ratioOut),
            color.withOpacity(opacity * (ratioIn * 0.8 + ratioOut * 0.2)),
          ],
          stops: [
            0.2,
            0.3 + ratioIn * 0.5 + ratioOut * 0.2,
          ],
        ),
      ),
    );
  }

  Widget _buildParticleField(BuildContext context, double ratio) {
    // remove after animation ends.
    if (ratio >= 1) return Container();

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
      ),
    ).fx().fadeOut(duration: detailT.ms, curve: Curves.easeIn);
  }

  Widget _buildIcon(BuildContext context, double ratio) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.33,
        heightFactor: 0.33,
        child: Hero(
          tag: 'collectible_icon_${collectible.id}',
          child: Image(
            image: collectible.icon,
            fit: BoxFit.contain,
          ).fx().scale(begin: 1, end: 2, curve: Curves.easeInExpo, duration: introTotalT.ms),
        ),
      ),
    );
  }

  Widget _buildBlur(BuildContext context, double ratio) {
    final double blur = ratio * 8;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(),
    );
  }

  Widget _buildImage(BuildContext context, double ratio) {
    return Hero(
      tag: 'collectible_image_${collectible.id}',
      child: Container(
        padding: EdgeInsets.all(context.insets.xxs),
        margin: EdgeInsets.symmetric(horizontal: context.insets.xl),
        decoration: BoxDecoration(color: context.colors.offWhite, boxShadow: [
          BoxShadow(
            color: context.colors.accent1.withOpacity(ratio * 0.75),
            blurRadius: context.insets.xl * 2,
          ),
          BoxShadow(
            color: context.colors.black.withOpacity(ratio * 0.75),
            offset: Offset(0, context.insets.xxs),
            blurRadius: context.insets.sm,
          ),
        ]),
        child: CachedNetworkImage(imageUrl: collectible.imageUrl),
      ),
    ).fx().scale(begin: 0.3, duration: 600.ms, curve: Curves.easeOutExpo).fade();
  }

  Widget _buildRibbon(BuildContext context, double ratio) {
    return AnimatedRibbon('Artifact Discovered'.toUpperCase())
        .fx()
        .scale(begin: 0.3, duration: 600.ms, curve: Curves.easeOutExpo)
        .fade();
  }

  Widget _buildTitle(BuildContext context, double ratio) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.insets.lg),
      child: Text(
        collectible.title,
        textAlign: TextAlign.center,
        style: context.textStyles.h2,
      ),
    ).fx().fade(delay: 450.ms, duration: 600.ms);
  }

  Widget _buildSubTitle(BuildContext context, double ratio) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.insets.lg),
      child: Text(
        collectible.subtitle.toUpperCase(),
        textAlign: TextAlign.center,
        style: context.textStyles.title2.copyWith(color: context.colors.accent1),
      ),
    ).fx().fade(delay: 600.ms, duration: 600.ms);
  }

  Widget _buildCollectionButton(BuildContext context, double ratio) {
    final double pad = context.insets.lg;
    return Container(
      padding: EdgeInsets.only(left: pad, right: pad, bottom: pad),
      child: AppTextBtn('view in my collection',
          isSecondary: true,
          expand: true,
          padding: EdgeInsets.all(context.insets.sm),
          onPressed: () => context.push(ScreenPaths.collection(collectible.id))),
    ).fx().fade(delay: 1200.ms, duration: 900.ms, curve: Curves.easeOut).move(begin: Offset(0, context.insets.xs));
  }

  Widget _buildCloseButton(BuildContext context, double ratio) {
    return PositionedBackBtn(useCloseIcon: true).fx().fade(delay: 1200.ms, duration: 900.ms);
  }
}
