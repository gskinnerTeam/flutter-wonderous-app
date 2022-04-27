import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class ChichenItzaIllustration extends StatelessWidget {
  ChichenItzaIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final String assetPath = WonderType.chichenItza.assetPath;

  @override
  Widget build(BuildContext context) {
    return WonderIllustrationBuilder(config: config, bgBuilder: _buildBg, mgBuilder: _buildMg, fgBuilder: _buildFg);
  }

  List<Widget> _buildBg(BuildContext context, Animation<double> anim) {
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
      Align(
        alignment: Alignment(0, config.shortMode ? 1 : 0),
        child: FractionalTranslation(
          translation: Offset(.7, config.shortMode ? .1 : -.1),
          child: WonderHero(
            config,
            'chichen-sun',
            child: FractionalTranslation(
              translation: Offset(0, -.2 * anim.value),
              child: Image.asset('$assetPath/sun.png', cacheWidth: context.widthPx.round() * 2, opacity: anim),
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
              scale: config.zoom,
              child: Image.asset(
                '$assetPath/pyramid.png',
                opacity: anim,
                cacheWidth: context.widthPx.round() * 2,
              ),
            )),
      ),
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    final curvedAnim = Curves.easeOut.transform(anim.value);
    return [
      Transform.scale(
        scale: 1 + (config.zoom - 1) / 3,
        child: Transform.translate(
            offset: Offset(0, (1 - curvedAnim) * 100),
            child: Stack(children: [
              BottomLeft(
                child: FractionalTranslation(
                  translation: Offset(-.3, -.3),
                  child: Image.asset('$assetPath/agave-left.png', opacity: anim, cacheWidth: context.widthPx.round()),
                ),
              ),
              BottomRight(
                child: FractionalTranslation(
                  translation: Offset(.35, -.35),
                  child: Transform.scale(
                    scale: 1.1,
                    child:
                        Image.asset('$assetPath/agave-right.png', opacity: anim, cacheWidth: context.widthPx.round()),
                  ),
                ),
              ),
            ])),
      )
    ];
  }
}
