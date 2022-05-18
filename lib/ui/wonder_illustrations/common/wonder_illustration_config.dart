/// Indicates the current setup for a WonderIllustration, allowing the single widget to be used in a variety of contexts.
class WonderIllustrationConfig {
  static const double _defaultZoom = 1;

  const WonderIllustrationConfig({
    this.zoom = _defaultZoom,
    this.isShowing = true,
    this.enableFg = true,
    this.enableBg = true,
    this.enableMg = true,
    this.enableHero = true,
    this.enableAnims = true,
    this.shortMode = false,
  });
  final double zoom;
  final bool isShowing;
  final bool enableFg;
  final bool enableBg;
  final bool enableMg;
  final bool enableHero;
  final bool enableAnims;
  final bool shortMode;

  /// Shortcut constructors to reduce boilerplate in the views when only 1 layer is required.
  factory WonderIllustrationConfig.fg({
    double zoom = _defaultZoom,
    bool isShowing = true,
    bool enableHero = true,
    bool enableAnims = true,
    bool shortMode = false,
  }) =>
      WonderIllustrationConfig(
        zoom: zoom,
        isShowing: isShowing,
        enableHero: enableHero,
        enableAnims: enableAnims,
        enableBg: false,
        enableMg: false,
        shortMode: shortMode,
      );
  factory WonderIllustrationConfig.bg({
    double zoom = _defaultZoom,
    bool isShowing = true,
    bool enableHero = true,
    bool enableAnims = true,
    bool shortMode = false,
  }) =>
      WonderIllustrationConfig(
        zoom: zoom,
        isShowing: isShowing,
        enableHero: enableHero,
        enableAnims: enableAnims,
        enableFg: false,
        enableMg: false,
        shortMode: shortMode,
      );
  factory WonderIllustrationConfig.mg({
    double zoom = _defaultZoom,
    bool isShowing = true,
    bool enableHero = true,
    bool enableAnims = true,
    bool shortMode = false,
  }) =>
      WonderIllustrationConfig(
        zoom: zoom,
        isShowing: isShowing,
        enableHero: enableHero,
        enableAnims: enableAnims,
        enableBg: false,
        enableFg: false,
        shortMode: shortMode,
      );
}
