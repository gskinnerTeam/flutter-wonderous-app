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
          scale: 2,
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
      FractionalTranslation(
        translation: Offset(0, -.03),
        child: Transform.scale(
          scale: 1 + (config.zoom - 1) / 2,
          child: Transform.scale(
            scale: config.shortMode ? .75 : .6,
            child: Center(
                child: Stack(
              children: [
                WonderHero(
                  config,
                  'taj',
                  child: Image.asset('$_assetPath/taj-mahal.png', fit: BoxFit.fitHeight, opacity: anim),
                ),
                Positioned.fill(
                  child: BottomCenter(
                    child: FractionalTranslation(
                      translation: Offset(0, .2),
                      child: OverflowBox(
                        maxWidth: double.infinity,
                        child: WonderHero(config, 'taj-wall',
                            child: Image.asset('$_assetPath/wall.png', fit: BoxFit.fitHeight, opacity: anim)),
                      ),
                    ),
                  ),
                ),
                if (!config.shortMode)
                  Positioned.fill(
                    child: BottomCenter(
                      child: OverflowBox(
                        maxWidth: double.infinity,
                        maxHeight: double.infinity,
                        child: FractionalTranslation(
                          translation: Offset(0, .8),
                          child: SizedBox(
                              height: 700,
                              child: Image.asset('$_assetPath/pool.png', fit: BoxFit.fitHeight, opacity: anim)),
                        ),
                      ),
                    ),
                  )
              ],
            )),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    final curvedAnim = Curves.easeOut.transform(anim.value);
    return [
      Transform.scale(
        scale: .8 + (config.zoom - 1) / 2,
        child: Stack(children: [
          BottomLeft(
            child: FractionalTranslation(
              translation: Offset(-.3 * (1 - curvedAnim), 0),
              child: Transform.rotate(
                angle: pi * -.1 * (1 - curvedAnim),
                child: FractionalTranslation(
                  translation: Offset(-.4, -.2),
                  child: Image.asset('$_assetPath/mangos-left.png', opacity: anim),
                ),
              ),
            ),
          ),
          BottomRight(
            child: FractionalTranslation(
              translation: Offset(.3 * (1 - curvedAnim), 0),
              child: Transform.rotate(
                angle: pi * .1 * (1 - curvedAnim),
                child: FractionalTranslation(
                  translation: Offset(.5, -.15),
                  child: Image.asset('$_assetPath/mangos-right.png', opacity: anim),
                ),
              ),
            ),
          ),
        ]),
      )
    ];
  }
}
