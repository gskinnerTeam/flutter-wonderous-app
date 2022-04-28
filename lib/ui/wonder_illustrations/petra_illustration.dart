import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class PetraIllustration extends StatelessWidget {
  PetraIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final String assetPath = WonderType.petra.assetPath;
  final fgColor = WonderType.petra.fgColor;
  final bgColor = WonderType.petra.bgColor;

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
          color: Colors.white,
          opacity: anim.drive(Tween(begin: 0, end: .2)),
        ),
      ),
      Align(
        alignment: Alignment(.5, -.7),
        child: WonderHero(
          config,
          'petra-sun',
          child: Transform.scale(
            scale: config.shortMode ? .75 : 1,
            child: Image.asset(
              '$assetPath/moon.png',
              cacheWidth: context.widthPx.round() * 2,
              opacity: anim,
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) => [
        Align(
          alignment: config.shortMode ? Alignment.bottomCenter : Alignment.center,
          child: WonderHero(
            config,
            'petra-mg',
            child: Transform.scale(
              scale: .8 + .2 * config.zoom,
              child: Image.asset(
                '$assetPath/petra.png',
                cacheWidth: context.widthPx.round() * 2,
                height: config.shortMode ? 220 : 600,
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
          offset: Offset(0, (1 - curvedAnim) * 100),
          child: Stack(children: [
            BottomLeft(
              child: Transform.scale(
                scale: .9 + config.zoom * .05,
                child: FractionalTranslation(
                  translation: Offset(-(config.zoom * .2), .1),
                  child: Image.asset('$assetPath/foreground-left.png',
                      opacity: anim, cacheWidth: context.widthPx.round() * 3),
                ),
              ),
            ),
            BottomRight(
              child: Transform.scale(
                scale: .9 + config.zoom * .05,
                child: FractionalTranslation(
                  translation: Offset(config.zoom * .2, .1),
                  child: Image.asset('$assetPath/foreground-right.png',
                      opacity: anim, cacheWidth: context.widthPx.round() * 3),
                ),
              ),
            ),
          ]))
    ];
  }
}
