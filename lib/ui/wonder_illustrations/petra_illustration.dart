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
        alignment: Alignment(-.5, -.7),
        child: WonderHero(
          config,
          'petra-sun',
          child: Image.asset(
            '$assetPath/moon.png',
            opacity: anim,
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
              scale: 1 + config.zoom * .2,
              child: FractionallySizedBox(
                widthFactor: config.shortMode ? 1 : 1.5,
                //scale: (config.shortMode ? 1 : 1.5) + .2 * config.zoom,
                child: Image.asset(
                  '$assetPath/petra.png',
                  fit: BoxFit.cover,
                  opacity: anim,
                ),
              ),
            ),
          ),
        )
      ];

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    final curvedAnim = Curves.easeOut.transform(anim.value);
    return [
      Transform.translate(
        offset: Offset(0, 30) * (1 - curvedAnim),
        child: Stack(
          children: [
            Transform.scale(
              scale: 1 + config.zoom * .2,
              child: BottomLeft(
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: FractionalTranslation(
                    translation: Offset(-.2, 0),
                    child: Image.asset('$assetPath/foreground-left.png', opacity: anim, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Transform.scale(
              scale: 1 + config.zoom * .1,
              child: BottomRight(
                child: FractionallySizedBox(
                  widthFactor: .7,
                  child: FractionalTranslation(
                    translation: Offset(.4 + config.zoom * .1, -0),
                    child: Image.asset('$assetPath/foreground-right.png', opacity: anim, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ];
  }
}
