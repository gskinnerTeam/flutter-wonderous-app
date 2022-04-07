import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class TajMahalIllustration extends StatelessWidget {
  const TajMahalIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;

  @override
  Widget build(BuildContext context) {
    final String assetPath = WonderType.tajMahal.assetPath;
    final fgColor = WonderType.tajMahal.fgColor;
    final bgColor = WonderType.tajMahal.bgColor;
    return WonderIllustrationBuilder(
        config: config,

        /// BG
        bgBuilder: (_, anim) {
          final curvedAnim = Curves.easeOut.transform(anim.value);
          return [
            Container(color: fgColor),

            /// Noise texture
            Positioned.fill(
              child: FractionalTranslation(
                  translation: Offset(.2, .1), child: RollerPaint1(bgColor.withOpacity(.5), scale: 2)),
            ),
            TopLeft(
              child: FractionalTranslation(
                translation: Offset(-.2 + curvedAnim * .2, .4 - curvedAnim * .2),
                child: WonderHero(config, 'taj-sun', child: Image.asset('$assetPath/sun.png')),
              ),
            )
          ];
        },

        /// MG
        mgBuilder: (_, __) {
          return [
            FractionalTranslation(
              translation: Offset(0, -.1),
              child: Transform.scale(
                scale: .65,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                        child: Stack(
                      children: [
                        WonderHero(
                          config,
                          'taj',
                          child: Image.asset('$assetPath/taj-mahal.png', fit: BoxFit.fitHeight),
                        ),
                        Positioned.fill(
                          child: BottomCenter(
                            child: FractionalTranslation(
                              translation: Offset(0, .2),
                              child: UnconstrainedBox(
                                child: WonderHero(config, 'taj-wall',
                                    child: Image.asset('$assetPath/wall.png', fit: BoxFit.fitHeight)),
                              ),
                            ),
                          ),
                        ),
                        if (config.enableFg) ...[
                          Positioned.fill(
                            child: BottomCenter(
                              child: UnconstrainedBox(
                                child: FractionalTranslation(
                                  translation: Offset(0, 1.13),
                                  child: Image.asset('$assetPath/pool.png', fit: BoxFit.fitHeight),
                                ),
                              ),
                            ),
                          )
                        ],
                      ],
                    )),
                  ],
                ),
              ),
            )
          ];
        },

        /// FG
        fgBuilder: (context, anim) {
          final curvedAnim = Curves.easeOut.transform(anim.value);
          return [
            FadeTransition(
              opacity: anim,
              child: Stack(children: [
                BottomLeft(
                  child: FractionalTranslation(
                    translation: Offset(-.3 * (1 - curvedAnim), 0),
                    child: Transform.rotate(
                      angle: pi * -.1 * (1 - curvedAnim),
                      child: FractionalTranslation(
                        translation: Offset(-.4, -.2),
                        child: Image.asset('$assetPath/mangos-left.png'),
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
                        child: Image.asset('$assetPath/mangos-right.png'),
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
