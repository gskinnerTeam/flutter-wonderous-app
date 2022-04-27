import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class ColosseumIllustration extends StatelessWidget {
  ColosseumIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final String assetPath = WonderType.colosseum.assetPath;
  final bgColor = WonderType.colosseum.bgColor;

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
    return [
      FadeColorTransition(animation: anim, color: context.colors.shift(bgColor, .15)),
      Positioned.fill(
        child: IllustrationTexture(
          ImagePaths.roller1,
          color: Colors.white,
          opacity: anim.drive(Tween(begin: 0, end: .5)),
        ),
      ),
      Align(
        alignment: config.shortMode ? Alignment.center : Alignment(-.5, -.7),
        child: WonderHero(
          config,
          'colosseum-sun',
          child: Transform.scale(
            scale: config.shortMode ? .75 : 1,
            child: Image.asset(
              '$assetPath/sun.png',
              cacheWidth: context.widthPx.round() * 2,
              opacity: anim,
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) {
    return [
      Stack(
        children: [
          if (config.shortMode) ...[
            FractionalTranslation(
              translation: Offset(0, .9),
              child: Container(color: bgColor),
            )
          ],
          Center(
            child: FractionalTranslation(
              translation: Offset(0, config.shortMode ? .1 : 0),
              child: WonderHero(
                config,
                'colosseum-mg',
                child: Transform.scale(
                  scale: config.shortMode ? .85 : .8 + config.zoom * .2,
                  child: Image.asset(
                    '$assetPath/colosseum.png',
                    cacheWidth: context.widthPx.round() * 2,
                    opacity: anim,
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    final curvedAnim = Curves.easeOut.transform(anim.value);
    return [
      Transform.translate(
          offset: Offset(0, (1 - curvedAnim) * 100),
          child: Stack(children: [
            BottomLeft(
              child: Transform.scale(
                scale: .6 + config.zoom * .35,
                child: FractionalTranslation(
                  translation: Offset(-.46, 0),
                  child: Image.asset('$assetPath/berries-left.png',
                      opacity: anim, cacheWidth: context.widthPx.round() * 3),
                ),
              ),
            ),
            BottomRight(
              child: Transform.scale(
                scale: .7 + config.zoom * .2,
                child: FractionalTranslation(
                  translation: Offset(.46, .1),
                  child: Image.asset('$assetPath/berries-right.png',
                      opacity: anim, cacheWidth: context.widthPx.round() * 3),
                ),
              ),
            ),
          ]))
    ];
  }
}
