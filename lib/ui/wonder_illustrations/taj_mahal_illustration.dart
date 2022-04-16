import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class TajMahalIllustration extends StatelessWidget {
  const TajMahalIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;

  @override
  Widget build(BuildContext context) {
    String assetPath = WonderType.tajMahal.assetPath;
    final fgColor = WonderType.tajMahal.fgColor;
    final bgColor = WonderType.tajMahal.bgColor;
    return WonderIllustrationBuilder(
        config: config,

        /// BG
        bgBuilder: (_, anim) {
          final curvedAnim = Curves.easeOut.transform(anim.value);
          return [
            // Bg color
            FadeColorTransition(color: fgColor, animation: anim),
            // Noise texture
            Positioned.fill(
              child: IllustrationTexture(
                ImagePaths.roller1,
                opacity: anim.drive(Tween(begin: 0, end: .3)),
                color: bgColor,
                scale: 2,
              ),
            ),
            // Sun
            TopLeft(
              child: FractionalTranslation(
                translation: Offset(-.2 + curvedAnim * .2, .4 - curvedAnim * .2),
                child: WonderHero(config, 'taj-sun', child: Image.asset('$assetPath/sun.png', opacity: anim)),
              ),
            )
          ];
        },

        /// MG
        mgBuilder: (_, anim) {
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
                        child: Image.asset('$assetPath/taj-mahal.png', fit: BoxFit.fitHeight, opacity: anim),
                      ),
                      Positioned.fill(
                        child: BottomCenter(
                          child: FractionalTranslation(
                            translation: Offset(0, .2),
                            child: OverflowBox(
                              maxWidth: double.infinity,
                              child: WonderHero(config, 'taj-wall',
                                  child: Image.asset('$assetPath/wall.png', fit: BoxFit.fitHeight, opacity: anim)),
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
                                    child: Image.asset('$assetPath/pool.png', fit: BoxFit.fitHeight, opacity: anim)),
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
        },

        /// FG
        fgBuilder: (context, anim) {
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
                        child: Image.asset('$assetPath/mangos-left.png', opacity: anim),
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
                        child: Image.asset('$assetPath/mangos-right.png', opacity: anim),
                      ),
                    ),
                  ),
                ),
              ]),
            )
          ];
        });
  }
}
