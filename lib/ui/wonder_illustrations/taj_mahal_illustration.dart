import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class TajMahalIllustration extends StatelessWidget {
  TajMahalIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;

  final fgColor = WonderType.tajMahal.fgColor;
  final bgColor = WonderType.tajMahal.bgColor;
  final assetPath = WonderType.tajMahal.assetPath;

  @override
  Widget build(BuildContext context) {
    return WonderIllustrationBuilder(
      config: config,
      bgBuilder: _buildBg,
      mgBuilder: _buildMg,
      fgBuilder: _buildFg,
    );
  }

  List<Widget> _buildBg(BuildContext context, Animation<double> anim) {
    final curvedAnim = Curves.easeOut.transform(anim.value);
    return [
      // Bg color
      FadeColorTransition(color: fgColor, animation: anim),
      // Noise texture
      Positioned.fill(
        child: IllustrationTexture(
          ImagePaths.roller1,
          flipY: true,
          opacity: anim.drive(Tween(begin: 0, end: 1)),
          color: bgColor,
        ),
      ),
      // Sun
      Align(
        alignment: config.shortMode ? Alignment(-1.25, -2.8) : Alignment(-1.25, -1.15),
        child: FractionalTranslation(
          translation: Offset(-.2 + curvedAnim * .2, .4 - curvedAnim * .2),
          child: WonderHero(config, 'taj-sun', child: Image.asset('$assetPath/sun.png', opacity: anim)),
        ),
      )
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) {
    return [
      Transform.scale(
        scale: 1 + config.zoom * .1,
        child: Align(
          alignment: Alignment(0, config.shortMode ? 1 : -.15),
          child: FractionallySizedBox(
            widthFactor: config.shortMode ? 1 : 1.7,
            child: Stack(
              children: [
                WonderHero(
                  config,
                  'taj-mg',
                  child: Image.asset('$assetPath/taj-mahal.png', opacity: anim, fit: BoxFit.cover),
                ),
                if (!config.shortMode)
                  FractionalTranslation(
                    translation: Offset(0, 1.33),
                    child: Image.asset('$assetPath/pool.png', opacity: anim, fit: BoxFit.cover),
                  ),
              ],
            ),
          ),
        ),
      )
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    final curvedAnim = Curves.easeOut.transform(anim.value);
    return [
      Transform.scale(
        scale: 1 + config.zoom * .2,
        child: Stack(
          children: [
            FractionalTranslation(
              translation: Offset(-.2 * (1 - curvedAnim), 0),
              child: BottomLeft(
                child: FractionallySizedBox(
                  heightFactor: .6,
                  child: FractionalTranslation(
                    translation: Offset(-.4, -.04),
                    child: Image.asset('$assetPath/foreground-left.png', opacity: anim, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            FractionalTranslation(
              translation: Offset(.2 * (1 - curvedAnim), 0),
              child: BottomRight(
                child: FractionallySizedBox(
                  heightFactor: .6,
                  child: FractionalTranslation(
                    translation: Offset(.4, -.04),
                    child: Image.asset('$assetPath/foreground-right.png', opacity: anim, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ];
  }
}
