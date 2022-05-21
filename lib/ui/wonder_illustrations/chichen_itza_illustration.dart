import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class ChichenItzaIllustration extends StatelessWidget {
  ChichenItzaIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final _assetPath = WonderType.chichenItza.assetPath;
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
          opacity: anim.drive(Tween(begin: 0, end: .3)),
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
                '$_assetPath/sun.png',
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
        alignment: Alignment(0, config.shortMode ? 1 : 0),
        child: WonderHero(config, 'chichen-mg',
            child: Transform.scale(
              scale: 1 + config.zoom * .2,
              child: FractionallySizedBox(
                widthFactor: config.shortMode ? 1.3 : 2.6,
                child: Image.asset('$_assetPath/chichen.png', opacity: anim, fit: BoxFit.cover),
              ),
            )),
      ),
    ];
  }

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
                    translation: Offset(-.5, 0),
                    child: Image.asset('$_assetPath/foreground-left.png', opacity: anim, fit: BoxFit.cover),
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
                    translation: Offset(.47, -.2),
                    child: Image.asset('$_assetPath/foreground-right.png', opacity: anim, fit: BoxFit.cover),
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
