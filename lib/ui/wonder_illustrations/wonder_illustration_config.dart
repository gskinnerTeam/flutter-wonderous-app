/// Indicates the current setup for a WonderIllustration, allowing the single widget to be used in a variety of contexts.
class WonderIllustrationConfig {
  const WonderIllustrationConfig({
    this.scale = 1.3,
    this.isShowing = true,
    this.enableFg = true,
    this.enableBg = true,
    this.enableMg = true,
    this.enableHero = true,
    this.enableAnims = true,
  });
  final bool enableFg;
  final bool enableBg;
  final bool enableMg;
  final bool isShowing;
  final double scale;
  final bool enableHero;
  final bool enableAnims;

  factory WonderIllustrationConfig.fg(
          {double scale = 1.3, bool isShowing = true, bool enableHero = true, bool enableAnims = true}) =>
      WonderIllustrationConfig(
        scale: scale,
        isShowing: isShowing,
        enableHero: enableHero,
        enableAnims: enableAnims,
        enableBg: false,
        enableMg: false,
      );
  factory WonderIllustrationConfig.bg(
          {double scale = 1.3, bool isShowing = true, bool enableHero = true, bool enableAnims = true}) =>
      WonderIllustrationConfig(
        scale: scale,
        isShowing: isShowing,
        enableHero: enableHero,
        enableAnims: enableAnims,
        enableFg: false,
        enableMg: false,
      );
  factory WonderIllustrationConfig.mg(
          {double wonderScale = 1.3, bool isShowing = true, bool enableHero = true, bool enableAnims = true}) =>
      WonderIllustrationConfig(
        scale: wonderScale,
        isShowing: isShowing,
        enableHero: enableHero,
        enableAnims: enableAnims,
        enableBg: false,
        enableFg: false,
      );
}
