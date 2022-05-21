import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class TajMahalIllustration extends StatelessWidget {
  TajMahalIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;

  final _fgColor = WonderType.tajMahal.fgColor;
  final _bgColor = WonderType.tajMahal.bgColor;
  final _assetPath = WonderType.tajMahal.assetPath;

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
      FadeColorTransition(color: _fgColor, animation: anim),
      // Noise texture
      Positioned.fill(
        child: IllustrationTexture(
          ImagePaths.roller1,
          opacity: anim.drive(Tween(begin: 0, end: .3)),
          color: _bgColor,
        ),
      ),
      // Sun
      Align(
        alignment: config.shortMode ? Alignment.topLeft : Alignment(-.8, -.8),
        child: FractionalTranslation(
          translation: Offset(-.2 + curvedAnim * .2, .4 - curvedAnim * .2),
          child: WonderHero(config, 'taj-sun', child: Image.asset('$_assetPath/sun.png', opacity: anim)),
        ),
      )
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) {
    return [
      Transform.scale(
        scale: 1 + config.zoom * .1,
        child: Align(
          alignment: Alignment(0, config.shortMode ? 1 : 0),
          child: FractionallySizedBox(
            widthFactor: config.shortMode ? 1 : 1.5,
            child: Stack(
              children: [
                Image.asset('$_assetPath/taj-mahal.png', opacity: anim, fit: BoxFit.cover),
                if (!config.shortMode)
                  FractionalTranslation(
                    translation: Offset(0, 1.45),
                    child: Transform.scale(
                      scale: 1.3,
                      child: Image.asset('$_assetPath/pool.png', opacity: anim, fit: BoxFit.cover),
                    ),
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
                  widthFactor: .7,
                  child: FractionalTranslation(
                    translation: Offset(-.3, 0),
                    child: Image.asset('$_assetPath/foreground-left.png', opacity: anim, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            FractionalTranslation(
              translation: Offset(.2 * (1 - curvedAnim), 0),
              child: BottomRight(
                child: FractionallySizedBox(
                  widthFactor: .7,
                  child: FractionalTranslation(
                    translation: Offset(.3, 0),
                    child: Image.asset('$_assetPath/foreground-right.png', opacity: anim, fit: BoxFit.cover),
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
