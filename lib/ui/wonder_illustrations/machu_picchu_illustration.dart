import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/illustration_piece.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class MachuPicchuIllustration extends StatelessWidget {
  MachuPicchuIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final String assetPath = WonderType.machuPicchu.assetPath;
  final fgColor = WonderType.machuPicchu.fgColor;
  final bgColor = WonderType.machuPicchu.bgColor;

  @override
  Widget build(BuildContext context) {
    return WonderIllustrationBuilder(
      config: config,
      bgBuilder: _buildBg,
      mgBuilder: _buildMg,
      fgBuilder: _buildFg,
      wonderType: WonderType.machuPicchu,
    );
  }

  List<Widget> _buildBg(BuildContext context, Animation<double> anim) {
    return [
      FadeColorTransition(animation: anim, color: fgColor),
      Positioned.fill(
        child: IllustrationTexture(
          ImagePaths.roller1,
          flipX: true,
          color: Colors.white,
          opacity: anim.drive(Tween(begin: 0, end: .7)),
        ),
      ),
      IllustrationPiece(
        fileName: 'sun.png',
        initialOffset: Offset(0, 20),
        enableHero: true,
        heightFactor: .15,
        minHeight: 150,
        offset: config.shortMode ? Offset(-70, context.heightPx * -.05) : Offset(-150, context.heightPx * -.25),
      ),
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) => [
        IllustrationPiece(
          fileName: 'machu-picchu.png',
          heightFactor: .65,
          minHeight: 500,
          zoomAmt: .05,
          enableHero: true,
        ),
      ];

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    return [
      IllustrationPiece(
        fileName: 'foreground-back.png',
        alignment: Alignment.bottomCenter,
        initialScale: .9,
        initialOffset: Offset(0, 60),
        heightFactor: .6,
        fractionalOffset: Offset(0, .3),
        zoomAmt: .1,
        dynamicHzOffset: 150,
      ),
      IllustrationPiece(
        fileName: 'foreground-front.png',
        alignment: Alignment.bottomCenter,
        initialOffset: Offset(20, 40),
        heightFactor: .5,
        initialScale: .95,
        fractionalOffset: Offset(-.25, .25),
        zoomAmt: .12,
        dynamicHzOffset: -50,
      ),
    ];
  }
}
