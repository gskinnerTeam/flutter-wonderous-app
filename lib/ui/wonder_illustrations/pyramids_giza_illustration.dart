import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class PyramidsGizaIllustration extends StatelessWidget {
  PyramidsGizaIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final String assetPath = WonderType.pyramidsGiza.assetPath;
  final fgColor = WonderType.pyramidsGiza.fgColor;
  final bgColor = WonderType.pyramidsGiza.bgColor;

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
          ImagePaths.roller2,
          color: Colors.white,
          opacity: anim.drive(Tween(begin: 0, end: .3)),
          flipY: true,
        ),
      ),
      Align(
          alignment: Alignment(.8, -.8),
          child: WonderHero(
            config,
            'pyramids-sun',
            child: Image.asset('$assetPath/moon.png', opacity: anim),
          )),
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) {
    return [
      Align(
        alignment: Alignment(0, config.shortMode ? 1 : 0),
        child: WonderHero(config, 'pyramids-mg',
            child: Transform.scale(
              scale: 1 + config.zoom * .1,
              child: FractionallySizedBox(
                widthFactor: config.shortMode ? 1.2 : 1.5,
                child: Image.asset('$assetPath/pyramids.png', opacity: anim),
              ),
            )),
      ),
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    return [
      Transform.scale(
        scale: 1 + config.zoom * .1,
        child: BottomCenter(
          child: FractionallySizedBox(
            widthFactor: 1.2,
            child: FractionalTranslation(
                translation: Offset(0, -1),
                child: Image.asset('$assetPath/foreground-back.png', opacity: anim, fit: BoxFit.cover)),
          ),
        ),
      ),
      Transform.scale(
        scale: 1 + config.zoom * .2,
        child: BottomCenter(
          child: FractionallySizedBox(
            widthFactor: 1.2,
            child: Image.asset('$assetPath/foreground-front.png', opacity: anim, fit: BoxFit.cover),
          ),
        ),
      )
      //
      // Transform.scale(
      //   scale: 1 + -.1 * (1 - curvedAnim),
      //   child: Stack(
      //     children: [
      //       Transform.scale(
      //         scale: 1 + config.zoom * .2,
      //         child: BottomLeft(
      //           child: FractionallySizedBox(
      //             widthFactor: .6,
      //             child: FractionalTranslation(
      //               translation: Offset(-.1, .1),
      //               child: Image.asset('$assetPath/foreground-back.png', opacity: anim, fit: BoxFit.cover),
      //             ),
      //           ),
      //         ),
      //       ),
      //       Transform.scale(
      //         scale: 1 + config.zoom * .16,
      //         child: BottomRight(
      //           child: FractionallySizedBox(
      //             widthFactor: .7,
      //             child: FractionalTranslation(
      //               translation: Offset(.3, .2),
      //               child: Image.asset('$assetPath/foreground-front.png', opacity: anim, fit: BoxFit.cover),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // )
    ];
  }
}
