import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class MachuPicchuIllustration extends StatelessWidget {
  MachuPicchuIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final String assetPath = WonderType.machuPicchu.assetPath;
  final fgColor = WonderType.machuPicchu.fgColor;
  final bgColor = WonderType.machuPicchu.bgColor;

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
      FadeColorTransition(animation: anim, color: fgColor),
      Positioned.fill(
        child: IllustrationTexture(
          ImagePaths.roller1,
          flipX: true,
          color: Colors.white,
          opacity: anim.drive(Tween(begin: 0, end: .7)),
        ),
      ),
      Align(
        alignment: config.shortMode ? Alignment.center : Alignment(.75, -.6),
        child: FractionalTranslation(
          translation: Offset(0, -.5 * anim.value),
          child: Transform.scale(
            scale: config.shortMode ? .75 : 1,
            child: WonderHero(
              config,
              'machu-sun',
              child: Image.asset(
                '$assetPath/sun.png',
                cacheWidth: context.widthPx.round() * 2,
                opacity: anim,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) => [
        Center(
          child: Transform.scale(
            scale: config.shortMode ? 1.2 : 2.5 + config.zoom * .2,
            alignment: Alignment(config.shortMode ? 0 : .15, config.shortMode ? -0.6 : .3),
            child: WonderHero(
              config,
              'machu-mg',
              child: Image.asset(
                '$assetPath/machu-picchu.png',
                fit: BoxFit.contain,
                opacity: anim,
              ),
            ),
          ),
        )
      ];

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    final curvedAnim = Curves.easeOut.transform(anim.value);
    return [
      Transform.translate(
        offset: Offset(0, 20 * (1 - curvedAnim)),
        child: Stack(children: [
          BottomRight(
            child: Transform.scale(
              scale: 1 + config.zoom * .05,
              child: FractionallySizedBox(
                widthFactor: 1.5,
                child: FractionalTranslation(
                  translation: Offset(0, .1),
                  child: Image.asset('$assetPath/foreground-back.png', opacity: anim),
                ),
              ),
            ),
          ),
          BottomLeft(
            child: FractionalTranslation(
              translation: Offset(-.2 * (1 - curvedAnim), 0),
              child: Transform.scale(
                scale: 1 + config.zoom * .25,
                child: FractionallySizedBox(
                  widthFactor: 1.5,
                  child: FractionalTranslation(
                    translation: Offset(-.3, .4),
                    child: Image.asset('$assetPath/foreground-front.png', opacity: anim),
                  ),
                ),
              ),
            ),
          ),
        ]),
      )
    ];
  }
}
