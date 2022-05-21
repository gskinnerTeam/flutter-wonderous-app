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
        alignment: Alignment(-.3, config.shortMode ? -1.5 : -1.25),
        child: WonderHero(
          config,
          'petra-moon',
          child: FractionalTranslation(
            translation: Offset(0, .5 * anim.value),

            child: Image.asset(
              '$assetPath/moon.png',
              opacity: anim,
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) => [
        FractionalTranslation(
          translation: Offset(0, config.shortMode ? 0.1 : 0.15),
          child: WonderHero(
            config,
            'petra-mg',
            child: Transform.scale(
              scale: 1 + config.zoom * .05,
              child: FractionallySizedBox(
                widthFactor: config.shortMode ? 1 : 2,
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
    Stack(children: [
      BottomLeft(
        child:FractionalTranslation(
          translation: Offset(-.3 * (1 - curvedAnim), 0),
          child: Transform.scale(
            scale: 1.1 + config.zoom * .2,
            child: FractionalTranslation(
              translation: Offset(-.2, -.12),
              child: Image.asset('$assetPath/foreground-left.png', opacity: anim, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
      BottomRight(
        child:FractionalTranslation(
          translation: Offset(.3 * (1 - curvedAnim), 0),
          child: Transform.scale(
            scale: 1 + config.zoom * .4,
            child: FractionalTranslation(
              translation: Offset(.4, -.08),
              child: Image.asset('$assetPath/foreground-right.png', opacity: anim, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    ])
    ];
  }
}
