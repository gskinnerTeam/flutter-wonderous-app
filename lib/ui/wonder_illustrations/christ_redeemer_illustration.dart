import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class ChristRedeemerIllustration extends StatelessWidget {
  const ChristRedeemerIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;

  @override
  Widget build(BuildContext context) {
    String assetPath = WonderType.christRedeemer.assetPath;
    final fgColor = WonderType.christRedeemer.fgColor;
    return WonderIllustrationBuilder(
      config: config,
      bgBuilder: (_, anim) => [
        FadeColorTransition(animation: anim, color: fgColor),
        Positioned.fill(
          child: IllustrationTexture(
            ImagePaths.roller1,
            color: Colors.white,
            opacity: anim.drive(Tween(begin: 0, end: .5)),
          ),
        ),
        Align(
          alignment: config.shortMode ? Alignment.center : Alignment(.5, -.7),
          child: WonderHero(
            config,
            'christ-sun',
            child: Transform.scale(
              scale: config.shortMode ? 1.4 : 1.2,
              child: Image.asset(
                '$assetPath/sun.png',
                cacheWidth: context.widthPx.round() * 2,
                opacity: anim,
              ),
            ),
          ),
        ),
      ],
      mgBuilder: (_, anim) => [
        ClipRect(
          child: BottomCenter(
            child: FractionalTranslation(
              translation: Offset(0, config.shortMode ? .4 : 0),
              child: WonderHero(
                config,
                'christ-mg',
                child: Transform.scale(
                  scale: config.shortMode ? 1.6 : .9 + config.zoom * .2,
                  child: Image.asset(
                    '$assetPath/redeemer.png',
                    cacheWidth: context.widthPx.round() * 2,
                    opacity: anim,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
      fgBuilder: (_, anim) {
        final curvedAnim = Curves.easeOut.transform(anim.value);
        return [
          Transform.translate(
              offset: Offset(0, (1 - curvedAnim) * 100),
              child: Stack(children: [
                BottomLeft(
                  child: Transform.scale(
                    scale: .8 + config.zoom * .35,
                    child: FractionalTranslation(
                      translation: Offset(-.46, 0),
                      child: Image.asset('$assetPath/foreground-left.png',
                          opacity: anim, cacheWidth: context.widthPx.round()),
                    ),
                  ),
                ),
                BottomRight(
                  child: Transform.scale(
                    scale: .9 + config.zoom * .2,
                    child: FractionalTranslation(
                      translation: Offset(.46, 0),
                      child: Image.asset('$assetPath/foreground-right.png',
                          opacity: anim, cacheWidth: context.widthPx.round()),
                    ),
                  ),
                ),
              ]))
        ];
      },
    );
  }
}
