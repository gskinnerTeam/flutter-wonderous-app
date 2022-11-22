import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/illustration_mg.dart';
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
          alignment: Alignment(.75, config.shortMode ? -.2 : -.5),
          child: FractionalTranslation(
            translation: Offset(0, -.5 * anim.value),
            child: WonderHero(
              config,
              'pyramids-moon',
              child: Transform.scale(
                scale: config.shortMode ? 0.8 : 1.2,
                child: Image.asset('$assetPath/moon.png', opacity: anim),
              ),
            ),
          )),
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) {
    return [
      IllustrationMg(
        'pyramids.png',
        type: WonderType.pyramidsGiza,
        anim: anim,
        config: config,
        maxHeight: 600,
        heightFraction: .85,
      ),

      // Align(
      //   alignment: Alignment(0, config.shortMode ? 0.9 : 0),
      //   child: WonderHero(config, 'pyramids-mg',
      //       child: Transform.scale(
      //         scale: 1 + config.zoom * .1,
      //         child: FractionallySizedBox(
      //           widthFactor: config.shortMode ? 1 : 1.94,
      //           child: Image.asset('$assetPath/pyramids.png', fit: BoxFit.contain, opacity: anim),
      //         ),
      //       )),
      // ),
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    final curvedAnim = Curves.easeOut.transform(anim.value);
    return [
      // Transform.scale(
      //   scale: 1 + config.zoom * .2,
      //   child: Transform.translate(
      //     offset: Offset(0, 10 * (1 - curvedAnim)),
      //     child: BottomCenter(
      //       child: FractionallySizedBox(
      //         widthFactor: 1.2,
      //         child: FractionalTranslation(
      //             translation: Offset(0, -1.2),
      //             child: Image.asset('$assetPath/foreground-back.png', opacity: anim, fit: BoxFit.cover)),
      //       ),
      //     ),
      //   ),
      // ),
      // Transform.scale(
      //   scale: 1 + config.zoom * .4,
      //   child: Transform.translate(
      //     offset: Offset(0, 30 * (1 - curvedAnim)),
      //     child: BottomCenter(
      //       child: FractionallySizedBox(
      //         widthFactor: 1.52,
      //         child: FractionalTranslation(
      //           translation: Offset(0, 0.1),
      //           child: Image.asset('$assetPath/foreground-front.png', opacity: anim, fit: BoxFit.cover),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    ];
  }
}
