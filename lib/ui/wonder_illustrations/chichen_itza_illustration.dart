import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/wonder_illustrations/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration_config.dart';

class ChichenItzaIllustration extends StatelessWidget {
  const ChichenItzaIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;

  @override
  Widget build(BuildContext context) {
    return WonderIllustrationBuilder(
        config: config,

        /// BG
        bgBuilder: (_, anim) => [
              Container(color: Color(0xfffbe7cc)),
              Positioned.fill(child: RollerPaint1(Color(0xFFDC762A).withOpacity(.4), scale: 1)),
              Center(
                child: FractionalTranslation(
                  translation: Offset(.7, 0),
                  child: WonderHero(config, 'chichen-sun',
                      child: FractionalTranslation(
                          translation: Offset(0, -.2 * anim.value),
                          child: Image.asset('assets/images/chichen_itza/sun.png'))),
                ),
              ),
            ],

        /// MG
        mgBuilder: (_, anim) => [
              Center(
                child: WonderHero(config, 'chichen-mg',
                    child: Transform.scale(
                      scale: config.scale,
                      child: Image.asset('assets/images/chichen_itza/pyramid.png'),
                    )),
              ),
            ],

        /// FG
        fgBuilder: (context, anim) {
          final curvedAnim = Curves.easeOut.transform(anim.value);
          return [
            Transform.translate(
              offset: Offset(0, 60 + (1 - curvedAnim) * 50),
              child: FadeTransition(
                opacity: anim,
                child: Stack(children: [
                  BottomLeft(
                    child: FractionalTranslation(
                      translation: Offset(-.3, -.3),
                      child: Image.asset('assets/images/chichen_itza/agave-left.png'),
                    ),
                  ),
                  BottomRight(
                    child: FractionalTranslation(
                      translation: Offset(.35, -.35),
                      child: Transform.scale(
                        scale: 1.1,
                        child: Image.asset('assets/images/chichen_itza/agave-right.png'),
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ];
        });
  }
}
