import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:particle_field/particle_field.dart';

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
      child: _buildIntro(context).animate().swap(
            delay: $styles.times.fast * 3.5,
            builder: (_, __) => _buildDetail(context),
          ),
    );
  }

  Widget _buildIntro(BuildContext context) {
    Duration t = $styles.times.fast;
    return Stack(children: [
      Animate().custom(duration: t * 5, builder: (context, ratio, _) => _buildGradient(context, ratio, 0)),

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
        ).animate().scale(begin: 1.5, end: 3, curve: Curves.easeInExpo, delay: t, duration: t * 3).fadeOut(),
      )
    ]);
  }

  Widget _buildDetail(BuildContext context) {
    Duration t = $styles.times.fast;
    return Stack(key: ValueKey('detail'), children: [
      Animate().custom(duration: t, builder: (context, ratio, _) => _buildGradient(context, 1, ratio)),
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
          _buildTitle(context, collectible.title, $styles.text.h2, $styles.colors.offWhite, t * 1.5),
          Gap($styles.insets.xs),
          _buildTitle(context, collectible.subtitle.toUpperCase(), $styles.text.title2, $styles.colors.accent1, t * 2),
          Spacer(flex: 2),
          _buildCollectionButton(context),
        ]),
      ),
      BackBtn.close().safe().animate().fade(delay: t * 4, duration: t * 2),
    ]);
  }

  Widget _buildGradient(BuildContext context, double ratioIn, double ratioOut) {
    // used by both intro and detail animations to ensure they share a mid-point.
    ratioIn = Curves.easeOutExpo.transform(ratioIn);
    final double opacity = 1.0 * (ratioIn * 0.8 + ratioOut * 0.2);
    final Color light = $styles.colors.offWhite;
    final Color dark = $styles.colors.black;

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
    Duration t = $styles.times.fast;
    // build an image with animated shadows and scaling
    return AppImage(image: imageProvider, scale: 1.0)
        .animate()
        .custom(
          duration: t * 6,
          builder: (_, ratio, child) => Container(
            padding: EdgeInsets.all($styles.insets.xxs),
            margin: EdgeInsets.symmetric(horizontal: $styles.insets.xl),
            decoration: BoxDecoration(color: $styles.colors.offWhite, boxShadow: [
              BoxShadow(
                color: $styles.colors.accent1.withOpacity(ratio * 0.75),
                blurRadius: $styles.insets.xl * 2,
              ),
              BoxShadow(
                color: $styles.colors.black.withOpacity(ratio * 0.75),
                offset: Offset(0, $styles.insets.xxs),
                blurRadius: $styles.insets.sm,
              ),
            ]),
            child: child,
          ),
        )
        .scale(begin: 0.3, duration: t * 2, curve: Curves.easeOutExpo, alignment: Alignment(0, 0.7));
  }

  Widget _buildRibbon(BuildContext context) {
    Duration t = $styles.times.fast;
    return _AnimatedRibbon($strings.collectibleFoundTitleArtifactDiscovered.toUpperCase())
        .animate()
        .scale(begin: 0.3, duration: t * 2, curve: Curves.easeOutExpo, alignment: Alignment(0, -1));
  }

  Widget _buildTitle(BuildContext context, String text, TextStyle style, Color color, Duration delay) {
    Duration t = $styles.times.fast;
    // because this is a performance-sensitive screen, we are fading in the text by adjusting color:
    return Container(
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg),
      child: Animate().custom(
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
    Duration t = $styles.times.fast;
    return Container(
      padding: EdgeInsets.all($styles.insets.lg),
      child: AppBtn.from(
        text: $strings.collectibleFoundButtonViewCollection,
        isSecondary: true,
        expand: true,
        onPressed: () => _handleViewCollectionPressed(context),
      ),
    )
        .animate()
        .show(delay: t * 4)
        .move(begin: Offset(0, $styles.insets.md), duration: t * 3, curve: Curves.easeOutCubic);
  }

  void _handleViewCollectionPressed(BuildContext context) {
    Navigator.pop(context);
    context.push(ScreenPaths.collection(collectible.id));
  }
}
