import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class ChichenItzaIllustration extends StatelessWidget {
  const ChichenItzaIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;

  @override
  Widget build(BuildContext context) {
    String assetPath = WonderType.chichenItza.assetPath;
    return WonderIllustrationBuilder(
        config: config,

        /// BG
        bgBuilder: (_, anim) {
          return [
            FadeColorTransition(animation: anim, color: WonderType.chichenItza.fgColor),
            Positioned.fill(
              child: IllustrationTexture(
                ImagePaths.roller2,
                color: Colors.white,
                opacity: anim.drive(Tween(begin: 0, end: .3)),
                flipY: true,
              ),
            ),
            Center(
              child: FractionalTranslation(
                translation: Offset(.7, 0),
                child: WonderHero(
                  config,
                  'chichen-sun',
                  child: FractionalTranslation(
                    translation: Offset(0, -.2 * anim.value),
                    child: Image.asset('$assetPath/sun.png', opacity: anim),
                  ),
                ),
              ),
            ),
          ];
        },

        /// MG
        mgBuilder: (_, anim) => [
              Center(
                child: WonderHero(config, 'chichen-mg',
                    child: Transform.scale(
                      scale: config.scale,
                      child: Image.asset('$assetPath/pyramid.png', opacity: anim),
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
                        child: Image.asset('$assetPath/agave-left.png', opacity: anim),
                      ),
                    ),
                    BottomRight(
                      child: FractionalTranslation(
                        translation: Offset(.35, -.35),
                        child: Transform.scale(
                          scale: 1.1,
                          child: Image.asset('$assetPath/agave-right.png', opacity: anim),
                        ),
                      ),
                    ),
                  ]),
                ))
          ];
        });
  }
}
