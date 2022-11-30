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
          flipX: false,
          color: Color(0xff1E736D),
          opacity: anim.drive(Tween(begin: 0, end: .5)),
          scale: config.shortMode ? 3 : 1,
        ),
      ),
      IllustrationPiece(
        fileName: 'sun.png',
        initialOffset: Offset(0, 50),
        enableHero: true,
        heightFactor: config.shortMode ? .15 : .15,
        minHeight: 100,
        offset: config.shortMode ? Offset(150, context.heightPx * -.08) : Offset(150, context.heightPx * -.35),
      ),
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) => [
        IllustrationPiece(
          fileName: 'machu-picchu.png',
          heightFactor: .65,
          minHeight: 230,
          zoomAmt: config.shortMode ? .1 : -1,
          enableHero: true,
          fractionalOffset: Offset(config.shortMode ? 0 : -.05, config.shortMode ? 0.12 : -.12),
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
        fractionalOffset: Offset(0, .2),
        zoomAmt: .05,
        dynamicHzOffset: 150,
      ),
      IllustrationPiece(
        fileName: 'foreground-front.png',
        alignment: Alignment.bottomCenter,
        initialOffset: Offset(20, 40),
        heightFactor: .6,
        initialScale: 1.2,
        fractionalOffset: Offset(-.35, .4),
        zoomAmt: .2,
        dynamicHzOffset: -50,
      ),
    ];
  }
}
