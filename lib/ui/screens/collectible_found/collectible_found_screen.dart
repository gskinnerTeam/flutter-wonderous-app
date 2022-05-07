import 'package:cached_network_image/cached_network_image.dart';
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
  final CachedNetworkImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: _buildIntro(context).fx().swap(
            delay: 1500.ms,
            builder: (_) => _buildDetail(context),
          ),
    );
  }

  Widget _buildIntro(BuildContext context) {
    return Stack(children: [
      FXAnimate().custom(duration: 1500.ms, builder: (context, ratio, _) => _buildGradient(context, ratio, 0)),

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
        ).fx().scale(begin: 1, end: 3, curve: Curves.easeInExpo, duration: 900.ms),
      )
    ]);
  }

  Widget _buildDetail(BuildContext context) {
    return Stack(key: ValueKey('detail'), children: [
      // radial gradient to solid fill in first 300ms:
      FXAnimate().custom(duration: 300.ms, builder: (context, ratio, _) => _buildGradient(context, 1, ratio)),
      _CelebrationParticles(),
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
          _buildTitle(context, collectible.title, context.textStyles.h2, context.colors.offWhite, 450),
          Gap(context.insets.xs),
          _buildTitle(
              context, collectible.subtitle.toUpperCase(), context.textStyles.title2, context.colors.accent1, 600),
          Spacer(flex: 2),
          _buildCollectionButton(context),
        ]),
      ),
      BackBtn.close().safe().fx().fade(delay: 1200.ms, duration: 900.ms),
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
    // build an image with animated shadows and scaling
    return Image(image: imageProvider)
        .fx()
        .custom(
          duration: 1800.ms,
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
        .scale(begin: 0.3, duration: 600.ms, curve: Curves.easeOutExpo, alignment: Alignment(0, 0.7));
  }

  Widget _buildRibbon(BuildContext buildContext) {
    return _AnimatedRibbon('Artifact Discovered'.toUpperCase())
        .fx()
        .scale(begin: 0.3, duration: 600.ms, curve: Curves.easeOutExpo, alignment: Alignment(0, -1));
  }

  Widget _buildTitle(BuildContext context, String text, TextStyle style, Color color, double delay) {
    // because this is a performance-sensitive screen, we are fading in the text by adjusting color:
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.insets.lg),
      child: FXAnimate().custom(
        delay: delay.ms,
        duration: 600.ms,
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
    return Container(
      padding: EdgeInsets.all(context.insets.lg),
      child: AppTextBtn(
        'view in my collection',
        isSecondary: true,
        expand: true,
        onPressed: () => context.push(ScreenPaths.collection(collectible.id)),
      ),
    ).fx().show(delay: 1200.ms).move(begin: Offset(0, context.insets.md), duration: 900.ms, curve: Curves.easeOutExpo);
  }
}
