import 'package:particle_field/particle_field.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/ui/common/app_backdrop.dart';
import 'package:wonders/ui/common/centered_box.dart';
import 'package:wonders/ui/common/controls/app_header.dart';
import 'package:wonders/ui/common/pop_navigator_underlay.dart';

part 'widgets/_animated_ribbon.dart';
part 'widgets/_celebration_particles.dart';

class CollectibleFoundScreen extends StatelessWidget {
  // CollectibleItem passes in a (theoretically) pre-loaded imageProvider.
  // we could check for load completion, and hold after introT, but that shouldn't be necessary in a real-world scenario.
  const CollectibleFoundScreen({required this.collectible, required this.imageProvider, super.key});

  final CollectibleData collectible;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: _buildIntro(context).animate().swap(
            delay: $styles.customTime.delay(1050),
            builder: (_, __) => _buildDetail(context),
          ),
    );
  }

  Widget _buildIntro(BuildContext context) {
    return Stack(children: [
      Animate().custom(duration: $styles.times.med, builder: (context, ratio, _) => _buildGradient(context, ratio, 0)),

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
        )
            .animate()
            .scale(begin: Offset(1.5, 1.5), end: Offset(3, 3), curve: Curves.easeInExpo, delay: $styles.times.fast, duration: $styles.times.slow)
            .fadeOut(),
      )
    ]);
  }

  Widget _buildDetail(BuildContext context) {
    return Stack(key: ValueKey('detail'), children: [
      /// Background
      AppBackdrop(
        strength: .5,
        child: Container(color: $styles.colors.greyStrong.withOpacity(.96)),
      ).animate().fadeIn(),

      /// Particles
      _CelebrationParticles(fadeMs: ($styles.customTime.delay(1800)).inMilliseconds),

      /// invisible close btn
      PopNavigatorUnderlay(),

      /// Content
      SafeArea(
        child: CenteredBox(
          width: $styles.sizes.maxContentWidth3,
          child: Column(
            children: [
              Gap($styles.insets.lg),
              Spacer(),
              SizedBox(
                height: context.heightPx * .35,
                child: Center(child: Hero(tag: 'collectible_image_${collectible.id}', child: _buildImage(context))),
              ),
              Gap($styles.insets.lg),
              _buildRibbon(context),
              Gap($styles.insets.sm),
              _buildTitle(context, collectible.title, $styles.text.h2, $styles.colors.offWhite, $styles.customTime.delay(450)),
              Gap($styles.insets.xs),
              _buildTitle(
                  context, collectible.subtitle.toUpperCase(), $styles.text.title2, $styles.colors.accent1, $styles.times.med),
              Spacer(),
              Gap($styles.insets.lg),
              _buildCollectionButton(context),
              Gap($styles.insets.lg),
              Spacer(),
            ],
          ),
        ),
      ),
      AppHeader(isTransparent: true).animate().fade(delay: $styles.customTime.delay(1200), duration: $styles.times.med),
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
    // build an image with animated shadows and scaling
    return AppImage(image: imageProvider, scale: 1.0)
        .animate()
        .custom(
          duration: $styles.customTime.duration(1800),
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
        .scale(begin: Offset(0.3, 0.3), duration: $styles.times.med, curve: Curves.easeOutExpo, alignment: Alignment(0, 0.7));
  }

  Widget _buildRibbon(BuildContext context) {
    return _AnimatedRibbon($strings.collectibleFoundTitleArtifactDiscovered.toUpperCase())
        .animate()
        .scale(begin: Offset(0.3, 0.3), duration: $styles.times.med, curve: Curves.easeOutExpo, alignment: Alignment(0, -1));
  }

  Widget _buildTitle(BuildContext context, String text, TextStyle style, Color color, Duration delay) {
    // because this is a performance-sensitive screen, we are fading in the text by adjusting color:
    return Container(
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg),
      child: Animate().custom(
        delay: delay,
        duration: $styles.times.med,
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
    Duration t = $styles.times.med;
    return AppBtn.from(
      text: $strings.collectibleFoundButtonViewCollection,
      isSecondary: true,
      onPressed: () => _handleViewCollectionPressed(context),
    ).animate().fadeIn(delay: t).move(
          begin: Offset(0, 50),
          duration: t,
          curve: Curves.easeOutCubic,
        );
  }

  void _handleViewCollectionPressed(BuildContext context) {
    Navigator.pop(context);
    context.go(ScreenPaths.collection(collectible.id));
  }
}
