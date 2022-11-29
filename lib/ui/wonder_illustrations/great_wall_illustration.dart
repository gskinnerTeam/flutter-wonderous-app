import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/illustration_piece.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class GreatWallIllustration extends StatelessWidget {
  GreatWallIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final String assetPath = WonderType.greatWall.assetPath;
  final fgColor = WonderType.greatWall.fgColor;
  final bgColor = WonderType.greatWall.bgColor;

  @override
  Widget build(BuildContext context) {
    return WonderIllustrationBuilder(
      config: config,
      bgBuilder: _buildBg,
      mgBuilder: _buildMg,
      fgBuilder: _buildFg,
      wonderType: WonderType.greatWall,
    );
  }

  List<Widget> _buildBg(BuildContext context, Animation<double> anim) {
    return [
      FadeColorTransition(animation: anim, color: $styles.colors.shift(fgColor, .15)),
      Positioned.fill(
        child: IllustrationTexture(
          ImagePaths.roller2,
          flipX: true,
          color: Colors.white,
          opacity: anim.drive(Tween(begin: 0, end: .5)),
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

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) {
    return [
      IllustrationPiece(
        fileName: 'great-wall.png',
        heightFactor: .55,
        minHeight: 500,
        zoomAmt: .05,
        enableHero: true,
      ),
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    return [
      IllustrationPiece(
        fileName: 'foreground-left.png',
        alignment: Alignment.bottomCenter,
        initialScale: .9,
        initialOffset: Offset(-40, 60),
        heightFactor: .75,
        fractionalOffset: Offset(-.4, .45),
        zoomAmt: .25,
        dynamicHzOffset: -150,
      ),
      IllustrationPiece(
        fileName: 'foreground-right.png',
        alignment: Alignment.bottomCenter,
        initialOffset: Offset(20, 40),
        initialScale: .95,
        heightFactor: .85,
        fractionalOffset: Offset(.4, .25),
        zoomAmt: .1,
        dynamicHzOffset: 150,
      ),
    ];
  }
}
