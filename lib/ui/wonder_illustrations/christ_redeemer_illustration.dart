import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/illustration_piece.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class ChristRedeemerIllustration extends StatelessWidget {
  ChristRedeemerIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final String assetPath = WonderType.christRedeemer.assetPath;
  final fgColor = WonderType.christRedeemer.fgColor;

  @override
  Widget build(BuildContext context) {
    return WonderIllustrationBuilder(
      config: config,
      bgBuilder: _buildBg,
      mgBuilder: _buildMg,
      fgBuilder: _buildFg,
      wonderType: WonderType.christRedeemer,
    );
  }

  List<Widget> _buildBg(BuildContext context, Animation<double> anim) {
    return [
      FadeColorTransition(animation: anim, color: fgColor),
      Positioned.fill(
        child: IllustrationTexture(
          ImagePaths.roller1,
          color: Colors.white,
          flipX: false,
          opacity: anim.drive(Tween(begin: 0, end: .4)),
        ),
      ),
      IllustrationPiece(
        fileName: 'sun.png',
        initialOffset: Offset(0, 20),
        enableHero: true,
        heightFactor: .2,
        minHeight: 120,
        fractionalOffset: Offset(.5, -1),
      ),
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) {
    return [
      IllustrationPiece(
        fileName: 'redeemer.png',
        enableHero: true,
        heightFactor: 1,
        alignment: Alignment.bottomCenter,
        fractionalOffset: Offset(0, .1),
        zoomAmt: .1,
      )
      //
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    return [
      IllustrationPiece(
        fileName: 'foreground-left.png',
        alignment: Alignment.bottomCenter,
        initialScale: .9,
        initialOffset: Offset(-40, 60),
        heightFactor: .55,
        fractionalOffset: Offset(-.25, 0),
        zoomAmt: .25,
        dynamicHzOffset: -100,
      ),
      IllustrationPiece(
        fileName: 'foreground-right.png',
        alignment: Alignment.bottomCenter,
        initialOffset: Offset(20, 40),
        initialScale: .95,
        heightFactor: .65,
        fractionalOffset: Offset(.2, 0),
        zoomAmt: .1,
        dynamicHzOffset: 100,
      ),
    ];
  }
}
