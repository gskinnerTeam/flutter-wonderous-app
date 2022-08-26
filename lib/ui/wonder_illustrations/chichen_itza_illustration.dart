import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class ChichenItzaIllustration extends StatelessWidget {
  ChichenItzaIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final assetPath = WonderType.chichenItza.assetPath;
  final fgColor = WonderType.chichenItza.fgColor;
  @override
  Widget build(BuildContext context) {
    return WonderIllustrationBuilder(config: config, bgBuilder: _buildBg, mgBuilder: _buildMg, fgBuilder: _buildFg);
  }

  List<Widget> _buildBg(BuildContext context, Animation<double> anim) {
    return [
      FadeColorTransition(animation: anim, color: fgColor),
      Positioned.fill(
        child: IllustrationTexture(
          ImagePaths.roller2,
          color: Colors.white,
          opacity: anim.drive(Tween(begin: 0, end: .5)),
          flipY: true,
        ),
      ),
      Align(
        alignment: Alignment(config.shortMode ? .25 : .7, config.shortMode ? 1 : -.15),
        child: WonderHero(
          config,
          'chichen-sun',
          child: FractionalTranslation(
            translation: Offset(0, -.2 * anim.value),
            child: Image.asset(
              '$assetPath/sun.png',
              width: config.shortMode ? 100 : 200,
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
      Align(
        alignment: Alignment(0, config.shortMode ? 1.2 : -.15),
        child: FractionallySizedBox(
          widthFactor: config.shortMode ? 1.5 : 2.6,
          child: WonderHero(
            config,
            'chichen-mg',
            child: Image.asset('$assetPath/chichen.png', opacity: anim, fit: BoxFit.contain),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    final curvedAnim = Curves.easeOut.transform(anim.value);
    return [
      Stack(
        children: [
          Transform.scale(
            scale: 1 + config.zoom * .2,
            child: FractionalTranslation(
              translation: Offset(-.2 * (1 - curvedAnim), 0),
              child: BottomLeft(
                child: FractionallySizedBox(
                  heightFactor: .5,
                  child: FractionalTranslation(
                    translation: Offset(-.4, 0),
                    child: Image.asset('$assetPath/foreground-left.png', opacity: anim, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          Transform.scale(
            scale: 1 + config.zoom * .1,
            child: FractionalTranslation(
              translation: Offset(.2 * (1 - curvedAnim), 0),
              child: BottomRight(
                child: FractionallySizedBox(
                  heightFactor: .33,
                  child: FractionalTranslation(
                    translation: Offset(.5, -.32),
                    child: Image.asset('$assetPath/foreground-right.png', opacity: anim, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          Transform.scale(
            scale: 1 + config.zoom * .15,
            child: FractionalTranslation(
              translation: Offset(-.2 * (1 - curvedAnim), 0),
              child: TopLeft(
                child: FractionallySizedBox(
                  heightFactor: .55,
                  child: FractionalTranslation(
                    translation: Offset(-.3, -.45),
                    child: Image.asset('$assetPath/top-left.png', opacity: anim, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          Transform.scale(
            scale: 1 + config.zoom * .3,
            child: FractionalTranslation(
              translation: Offset(.2 * (1 - curvedAnim), 0),
              child: TopRight(
                child: FractionallySizedBox(
                  heightFactor: .65,
                  child: FractionalTranslation(
                    translation: Offset(.45, -.35),
                    child: Image.asset('$assetPath/top-right.png', opacity: anim, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }
}
