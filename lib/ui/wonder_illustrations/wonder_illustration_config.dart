/// Indicates the current setup for a WonderIllustration, allowing the single widget to be used in a variety of contexts.
class WonderIllustrationConfig {
  const WonderIllustrationConfig(
      {this.isShowing = true, this.enableFg = true, this.enableBg = true, this.enableMg = true});
  final bool enableFg;
  final bool enableBg;
  final bool enableMg;
  final bool isShowing;

  factory WonderIllustrationConfig.fg({bool isShowing = true}) => WonderIllustrationConfig(
        isShowing: isShowing,
        enableBg: false,
        enableMg: false,
      );
  factory WonderIllustrationConfig.bg({bool isShowing = true}) => WonderIllustrationConfig(
        isShowing: isShowing,
        enableFg: false,
        enableMg: false,
      );
  factory WonderIllustrationConfig.mg({bool isShowing = true}) => WonderIllustrationConfig(
        isShowing: isShowing,
        enableBg: false,
        enableFg: false,
      );
}
