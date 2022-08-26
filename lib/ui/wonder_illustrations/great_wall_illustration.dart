import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class GreatWallIllustration extends StatelessWidget {
  GreatWallIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final String assetPath = WonderType.greatWall.assetPath;
  final fgColor = WonderType.greatWall.fgColor;
  final bgColor = WonderType.greatWall.bgColor;

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
      FadeColorTransition(animation: anim, color: $styles.colors.shift(fgColor, .15)),
      Positioned.fill(
        child: IllustrationTexture(
          ImagePaths.roller2,
          flipX: true,
          color: Colors.white,
          opacity: anim.drive(Tween(begin: 0, end: .5)),
        ),
      ),
      Align(
        alignment: config.shortMode ? Alignment(-.5, -.5) : Alignment(-.45, -.63),
        child: FractionalTranslation(
          translation: Offset(0, -.5 * anim.value),
          child: WonderHero(
            config,
            'great-wall-sun',
            child: Image.asset(
              '$assetPath/sun.png',
              cacheWidth: context.widthPx.round() * 2,
              width: config.shortMode ? 100 : 150,
              opacity: anim,
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) => [
        Center(
          child: FractionalTranslation(
            translation: Offset(0, config.shortMode ? .1 * anim.value : 0),
            child: FractionallySizedBox(
              widthFactor: config.shortMode ? null : 1.3,
              child: WonderHero(
                config,
                'great-wall-mg',
                child: Image.asset(
                  '$assetPath/great-wall.png',
                  opacity: anim,
                  width: config.shortMode ? 300 : 500,
                ),
              ),
            ),
          ),

          // child: FractionalTranslation(
          //   translation: Offset(0, 0),
          //   child: Transform.scale(
          //     scale: 1, //config.shortMode ? .95 : 1.4 + config.zoom * .2,
          //     child: WonderHero(
          //       config,
          //       'great-wall-mg',
          //       child: Image.asset(
          //         '$assetPath/great-wall.png',
          //         opacity: anim,
          //         width: 700,
          //       ),
          //     ),
          //   ),
          // ),
        )
      ];

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    final curvedAnim = Curves.easeOut.transform(anim.value);
    return [
      Stack(children: [
        BottomRight(
          child: FractionalTranslation(
            translation: Offset(.2 * (1 - curvedAnim), 0),
            child: Transform.scale(
              scale: 1.5 + config.zoom * .1,
              child: FractionalTranslation(
                translation: Offset(.46, -.22),
                child: Image.asset('$assetPath/foreground-right.png',
                    opacity: anim, cacheWidth: context.widthPx.round() * 3),
              ),
            ),
          ),
        ),
        BottomLeft(
          child: FractionalTranslation(
            translation: Offset(-.2 * (1 - curvedAnim), 0),
            child: Transform.scale(
              scale: 1 + config.zoom * .3,
              child: FractionalTranslation(
                translation: Offset(-.3, -.01),
                child: Image.asset('$assetPath/foreground-left.png',
                    opacity: anim, cacheWidth: context.widthPx.round() * 3),
              ),
            ),
          ),
        ),
      ])
    ];
  }
}
