import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/illustration_piece.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class ColosseumIllustration extends StatelessWidget {
  ColosseumIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final String assetPath = WonderType.colosseum.assetPath;
  final bgColor = WonderType.colosseum.bgColor;

  @override
  Widget build(BuildContext context) {
    return WonderIllustrationBuilder(
      config: config,
      bgBuilder: _buildBg,
      mgBuilder: _buildMg,
      fgBuilder: _buildFg,
      wonderType: WonderType.colosseum,
    );
  }

  List<Widget> _buildBg(BuildContext context, Animation<double> anim) {
    return [
      FadeColorTransition(animation: anim, color: $styles.colors.shift(bgColor, .15)),
      Positioned.fill(
        child: IllustrationTexture(
          ImagePaths.roller1,
          color: Colors.white,
          opacity: anim.drive(Tween(begin: 0, end: .5)),
        ),
      ),
      Align(
        alignment: config.shortMode ? Alignment(-.3, 1) : Alignment(-.5, -.4),
        child: FractionalTranslation(
          translation: Offset(0, -.5 * anim.value),
          child: WonderHero(
            config,
            'colosseum-sun',
            child: Transform.scale(
              scale: config.shortMode ? .75 : 1,
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

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) {
    return [
      Stack(
        children: const [
          IllustrationPiece(
            fileName: 'colosseum.png',
            heightFactor: .55,
            minHeight: 400,
            zoomAmt: .15,
          ),
        ],
      )
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    return [
      IllustrationPiece(
        fileName: 'foreground-left.png',
        alignment: Alignment.bottomCenter,
        initialScale: .9,
        initialOffset: Offset(-40, 60),
        heightFactor: .65,
        fractionalOffset: Offset(-.5, .1),
        zoomAmt: .25,
        dynamicHzOffset: -150,
      ),
      IllustrationPiece(
        fileName: 'foreground-right.png',
        alignment: Alignment.bottomCenter,
        initialOffset: Offset(20, 40),
        initialScale: .95,
        heightFactor: .75,
        fractionalOffset: Offset(.5, .25),
        zoomAmt: .1,
        dynamicHzOffset: 150,
      ),
    ];
  }
}
