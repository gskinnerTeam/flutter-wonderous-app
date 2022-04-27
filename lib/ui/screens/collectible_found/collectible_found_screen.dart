import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/ui/common/particles/particle_field.dart';

part 'widgets/_animated_ribbon.dart';
part 'widgets/_celebration_particles.dart';

// TODO: GDS: maybe: title text size (2 line max): https://pub.dev/packages/auto_size_text

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
    return RepaintBoundary(
      child: FXBuilder(
        duration: totalT.ms,
        builder: (ctx, ratio, _) => Stack(children: [
          ..._buildIntro(context, ratio),
          ..._buildDetail(context, ratio),
        ]),
      ),
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
      // radial gradient to solid fill in first 300ms:
      _buildGradient(context, 1, _subRatio(ratio, introTotalT, 300)),
      // fade out and then remove particles completely at the end:
      _CelebrationParticles(),
      // add the detail UI in a column to facilitate better responsiveness:
      SafeArea(
        child: Column(children: [
          Spacer(flex: 5),
          Flexible(flex: 18, child: _buildImage(context, detailRatio)),
          Spacer(flex: 2),
          _buildRibbon(context, detailRatio),
          Spacer(flex: 1),
          _buildTitle(context, collectible.title, context.textStyles.h2, context.colors.offWhite, 450),
          Spacer(flex: 1),
          _buildTitle(
              context, collectible.subtitle.toUpperCase(), context.textStyles.title2, context.colors.accent1, 600),
          Spacer(flex: 3),
          _buildCollectionButton(context, detailRatio),
        ]),
      ),
      _buildCloseButton(context, detailRatio),
    ];
  }

  Widget _buildGradient(BuildContext context, double ratioIn, double ratioOut) {
    final double opacity = 0.9 * (Curves.easeOutExpo.transform(ratioIn) * 0.8 + ratioOut * 0.2);
    final Color light = context.colors.offWhite;
    final Color dark = context.colors.black;

    // final state is a solid fill, so optimize for that:
    if (ratioOut == 1) return Container(color: dark.withOpacity(opacity));

    ratioIn = Curves.easeOutQuint.transform(ratioIn);
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color.lerp(light, dark, ratioOut)!.withOpacity(opacity),
            dark.withOpacity(opacity),
          ],
          stops: [
            0.2,
            min(1, 0.25 + ratioIn * 0.5 + ratioOut * 0.5),
          ],
        ),
      ),
    );
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

  Widget _buildImage(BuildContext context, double ratio) {
    return Center(
      child: Hero(
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
          child: Image(image: imageProvider),
        ),
      ),
    ).fx().scale(begin: 0.3, duration: 600.ms, curve: Curves.easeOutExpo, alignment: Alignment(0, 0.7));
  }

  Widget _buildRibbon(BuildContext context, double ratio) {
    return _AnimatedRibbon('Artifact Discovered'.toUpperCase())
        .fx()
        .scale(begin: 0.3, duration: 600.ms, curve: Curves.easeOutExpo, alignment: Alignment(0, -1));
  }

  Widget _buildTitle(BuildContext context, String text, TextStyle style, Color color, double delay) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.insets.lg),
      child: FXBuilder(
        delay: delay.ms,
        duration: 600.ms,
        builder: (_, m, __) =>
            Text(text, textAlign: TextAlign.center, style: style.copyWith(color: color.withOpacity(m))),
      ),
    );
  }

  Widget _buildCollectionButton(BuildContext context, double ratio) {
    final double pad = context.insets.lg;
    return Container(
      padding: EdgeInsets.only(left: pad, right: pad, bottom: pad),
      child: AppTextBtn(
        'view in my collection',
        isSecondary: true,
        expand: true,
        onPressed: () => context.push(ScreenPaths.collection(collectible.id)),
      ),
    ).fx().show(delay: 1200.ms).move(begin: Offset(0, context.insets.md), duration: 900.ms, curve: Curves.easeOutExpo);
  }

  Widget _buildCloseButton(BuildContext context, double ratio) {
    return BackBtn.close().padded().fx().fade(delay: 1200.ms, duration: 900.ms);
  }
}
