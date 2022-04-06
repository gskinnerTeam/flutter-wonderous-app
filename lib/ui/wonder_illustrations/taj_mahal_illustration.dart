import 'dart:math' as math;

import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/blend_mask.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class TajMahalIllustration extends StatelessWidget {
  const TajMahalIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;

  @override
  Widget build(BuildContext context) => WonderIllustrationBuilder(
      config: config,

      /// BG
      bgBuilder: (_, anim) {
        final fgColor = context.colors.wonderFg(WonderType.tajMahal);
        final bgColor = context.colors.wonderBg(WonderType.tajMahal);
        final curvedAnim = Curves.easeOut.transform(anim.value);
        return [
          AnimatedBuilder(animation: anim, builder: (context, _) {
            return Container(color: fgColor.withOpacity(anim.value));
          }),
          AnimatedBuilder(animation: anim, builder: (context, _) {
            /// Noise texture
            return Positioned.fill(
              child: FractionalTranslation(
                translation: Offset(.2, .1), child: RollerPaint1(bgColor.withOpacity(math.max(anim.value, 0.5)), scale: 2)),
              );
            },
          ),
          TopLeft(
            child: FractionalTranslation(
              translation: Offset(-.2 + curvedAnim * .2, .4 - curvedAnim * .2),
              child: WonderHero(config, 'taj-sun', child: Image.asset('assets/images/taj_mahal/sun.png', opacity: anim)),
            ),
          )
        ];
      },

      /// MG
      mgBuilder: (_, anim) {
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
                        child: Image.asset('assets/images/taj_mahal/taj-mahal.png', fit: BoxFit.fitHeight, opacity: anim),
                      ),
                      Positioned.fill(
                        child: BottomCenter(
                          child: FractionalTranslation(
                            translation: Offset(0, .2),
                            child: UnconstrainedBox(
                              child: WonderHero(config, 'taj-wall',
                                  child: Image.asset('assets/images/taj_mahal/wall.png', fit: BoxFit.fitHeight, opacity: anim)),
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
                                child: Image.asset('assets/images/taj_mahal/pool.png', fit: BoxFit.fitHeight, opacity: anim),
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
          ),
        ];
      },

      /// FG
      fgBuilder: (context, anim) {
        final curvedAnim = Curves.easeOut.transform(anim.value);
        return [
          Stack(children: [
            BottomLeft(
              child: FractionalTranslation(
                translation: Offset(-.3 * (1 - curvedAnim), 0),
                child: Transform.rotate(
                  angle: pi * -.1 * (1 - curvedAnim),
                  child: FractionalTranslation(
                      translation: Offset(-.4, -.2),
                      child: Image.asset('assets/images/taj_mahal/mangos-left.png', opacity: anim)),
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
                    child: Image.asset('assets/images/taj_mahal/mangos-right.png', opacity: anim),
                  ),
                ),
              ),
            ),
          ])
        ];
      });
}
