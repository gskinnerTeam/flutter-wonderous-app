import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/blend_mask.dart';
import 'package:wonders/ui/wonder_illustrations/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration_config.dart';

class TajMahalIllustration extends StatelessWidget {
  const TajMahalIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;

  @override
  Widget build(BuildContext context) => WonderIllustrationBuilder(
      config: config,
      bgBuilder: (_, anim) => [
            AnimatedBuilder(
                animation: anim,
                builder: (context, child) {
                  return Container(color: Color(0xff8b4641).withOpacity(anim.value));
                }),
            Positioned.fill(
              child: BlendMask(
                blendModes: const [BlendMode.overlay],
                opacity: .3,
                child: FractionalTranslation(
                  translation: Offset(.2, .1),
                  child: AnimatedBuilder(
                      animation: anim,
                      builder: (context, child) {
                        return RollerPaint1(Colors.white.withOpacity(anim.value), scale: 2);
                      }),
                ),
              ),
            ),
            Center(
              child: Transform.translate(
                offset: Offset(-150, -310),
                child: GTweener(
                  [GMove(from: Offset(-100, 20))],
                  duration: context.times.med,
                  curve: Curves.easeOut,
                  child: Image.asset('assets/images/taj_mahal/sun.png', opacity: anim),
                ),
              ),
            )
          ],
      mgBuilder: (_, anim) {
        double size = 320;
        return [
          Transform.translate(
            offset: Offset(0, -size * .1),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                    child: WonderHero(config, 'taj',
                        child: Image.asset('assets/images/taj_mahal/taj-mahal.png', opacity: anim),
                      ),
                    ),
                Center(
                  child: Transform.translate(
                    offset: Offset(0, size * .22),
                    child: UnconstrainedBox(
                      child: SizedBox(
                        height: size,
                        child: Image.asset('assets/images/taj_mahal/wall.png', fit: BoxFit.fitHeight, opacity: anim),
                      ),
                    ),
                  ),
                ),
                if (config.enableFg) ...[
                  Center(
                    child: UnconstrainedBox(
                      child: SizedBox(
                        height: size * 1,
                        child: FractionalTranslation(
                          translation: Offset(0, 1.13),
                          child: Image.asset('assets/images/taj_mahal/pool.png', fit: BoxFit.fitHeight, opacity: anim),
                        ),
                      ),
                    ),
                  )
                ],
              ],
            ),
          ),
        ];
      },
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
