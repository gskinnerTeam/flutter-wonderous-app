import 'package:image_fade/image_fade.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/ui/common/particles/particle_field.dart';

part 'widgets/_animated_ribbon.dart';
part 'widgets/_celebration_particles.dart';

class CollectibleFoundScreen extends StatelessWidget {
  // CollectibleItem passes in a (theoretically) pre-loaded imageProvider.
  // we could check for load completion, and hold after introT, but that shouldn't be necessary in a real-world scenario.
  const CollectibleFoundScreen({required this.collectible, required this.imageProvider, Key? key}) : super(key: key);

  final CollectibleData collectible;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: _buildIntro(context).fx().swap(
            delay: context.times.fast * 3,
            builder: (_) => _buildDetail(context),
          ),
    );
  }

  Widget _buildIntro(BuildContext context) {
    Duration t = context.times.fast;
    return Stack(children: [
      FXAnimate().custom(duration: t * 5, builder: (context, ratio, _) => _buildGradient(context, ratio, 0)),

      // icon is handled by Hero initially, then scales slowly:
      Center(
        child: FractionallySizedBox(
          widthFactor: 0.33,
          heightFactor: 0.33,
          child: Hero(
            tag: 'collectible_icon_${collectible.id}',
            child: Image(
              image: collectible.icon,
              fit: BoxFit.contain,
            ),
          ),
        ).fx().scale(begin: 1, end: 3, curve: Curves.easeInExpo, delay: t, duration: t * 3),
      )
    ]);
  }

  Widget _buildDetail(BuildContext context) {
    Duration t = context.times.fast;
    return Stack(key: ValueKey('detail'), children: [
      FXAnimate().custom(duration: t, builder: (context, ratio, _) => _buildGradient(context, 1, ratio)),
      _CelebrationParticles(fadeMs: (t * 6).inMilliseconds),
      SafeArea(
        child: Column(children: [
          Spacer(flex: 5),
          Flexible(
            flex: 18,
            child: Center(child: Hero(tag: 'collectible_image_${collectible.id}', child: _buildImage(context))),
          ),
          Spacer(flex: 2),
          _buildRibbon(context),
          Spacer(flex: 2),
          _buildTitle(context, collectible.title, context.textStyles.h2, context.colors.offWhite, t * 1.5),
          Gap(context.insets.xs),
          _buildTitle(
              context, collectible.subtitle.toUpperCase(), context.textStyles.title2, context.colors.accent1, t * 2),
          Spacer(flex: 2),
          _buildCollectionButton(context),
        ]),
      ),
      BackBtn.close().safe().fx().fade(delay: t * 4, duration: t * 2),
    ]);
  }

  Widget _buildGradient(BuildContext context, double ratioIn, double ratioOut) {
    // used by both intro and detail animations to ensure they share a mid-point.
    ratioIn = Curves.easeOutExpo.transform(ratioIn);
    final double opacity = 0.9 * (ratioIn * 0.8 + ratioOut * 0.2);
    final Color light = context.colors.offWhite;
    final Color dark = context.colors.black;

    // final state is a solid fill, so optimize that case:
    if (ratioOut == 1) return Container(color: dark.withOpacity(opacity));

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Color.lerp(light, dark, ratioOut)!.withOpacity(opacity), dark.withOpacity(opacity)],
          stops: [0.2, min(1, 0.25 + ratioIn * 0.5 + ratioOut * 0.5)],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    Duration t = context.times.fast;
    // build an image with animated shadows and scaling
    return ImageFade(image: imageProvider, duration: t * 0.5)
        .fx()
        .custom(
          duration: t * 6,
          builder: (_, ratio, child) => Container(
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
            child: child,
          ),
        )
        .scale(begin: 0.3, duration: t * 2, curve: Curves.easeOutExpo, alignment: Alignment(0, 0.7));
  }

  Widget _buildRibbon(BuildContext context) {
    Duration t = context.times.fast;
    return _AnimatedRibbon('Artifact Discovered'.toUpperCase())
        .fx()
        .scale(begin: 0.3, duration: t * 2, curve: Curves.easeOutExpo, alignment: Alignment(0, -1));
  }

  Widget _buildTitle(BuildContext context, String text, TextStyle style, Color color, Duration delay) {
    Duration t = context.times.fast;
    // because this is a performance-sensitive screen, we are fading in the text by adjusting color:
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.insets.lg),
      child: FXAnimate().custom(
        delay: delay,
        duration: t * 2,
        builder: (_, m, __) => Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: style.copyWith(color: color.withOpacity(m)),
        ),
      ),
    );
  }

  Widget _buildCollectionButton(BuildContext context) {
    Duration t = context.times.fast;
    return Container(
      padding: EdgeInsets.all(context.insets.lg),
      child: AppBtn.from(
        text: 'view in my collection',
        isSecondary: true,
        expand: true,
        onPressed: () {
          context.push(ScreenPaths.collection(collectible.id));
        },
      ),
    ).fx().show(delay: t * 4).move(begin: Offset(0, context.insets.md), duration: t * 3, curve: Curves.easeOutExpo);
  }
}
