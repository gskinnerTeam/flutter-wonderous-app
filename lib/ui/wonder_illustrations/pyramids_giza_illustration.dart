import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/illustration_piece.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
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
      wonderType: WonderType.pyramidsGiza,
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
      IllustrationPiece(
        fileName: 'moon.png',
        initialOffset: Offset(0, 20),
        enableHero: true,
        heightFactor: .15,
        minHeight: 100,
        offset: config.shortMode ? Offset(100, context.heightPx * -.1) : Offset(150, context.heightPx * -.15),
        zoomAmt: .05,
      ),
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) {
    return [
      IllustrationPiece(
        fileName: 'pyramids.png',
        enableHero: true,
        heightFactor: .5,
        minHeight: 300,
        zoomAmt: .1,
        boxFit: BoxFit.contain,
        overflow: !config.shortMode,
      )
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    return [
      IllustrationPiece(
        fileName: 'foreground-back.png',
        alignment: Alignment.bottomCenter,
        initialOffset: Offset(20, 40),
        initialScale: .95,
        heightFactor: .55,
        fractionalOffset: Offset(.1, .06),
        zoomAmt: .1,
        dynamicHzOffset: 150,
      ),
      IllustrationPiece(
        fileName: 'foreground-front.png',
        alignment: Alignment.bottomCenter,
        initialScale: .9,
        initialOffset: Offset(-40, 60),
        heightFactor: .55,
        fractionalOffset: Offset(-.1, .1),
        zoomAmt: .25,
        dynamicHzOffset: -150,
      ),
    ];
  }
}
