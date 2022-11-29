import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/illustration_piece.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_illustration_config.dart';

class ChichenItzaIllustration extends StatelessWidget {
  ChichenItzaIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;
  final assetPath = WonderType.chichenItza.assetPath;
  final fgColor = WonderType.chichenItza.fgColor;
  @override
  Widget build(BuildContext context) {
    return WonderIllustrationBuilder(
      config: config,
      bgBuilder: _buildBg,
      mgBuilder: _buildMg,
      fgBuilder: _buildFg,
      wonderType: WonderType.chichenItza,
    );
  }

  List<Widget> _buildBg(BuildContext context, Animation<double> anim) {
    return [
      FadeColorTransition(animation: anim, color: fgColor),
      Positioned.fill(
        child: IllustrationTexture(
          ImagePaths.roller2,
          color: Colors.white,
          opacity: anim.drive(Tween(begin: 0, end: .5)),
          flipY: true,
        ),
      ),
      IllustrationPiece(
        fileName: 'sun.png',
        initialOffset: Offset(0, 20),
        enableHero: true,
        heightFactor: .25,
        minHeight: 200,
        fractionalOffset: Offset(1, config.shortMode ? 0 : -.5),
      ),
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) {
    // We want to size to the shortest side
    return [
      Transform.translate(
        offset: Offset(0, 20),
        child: IllustrationPiece(
          fileName: 'chichen.png',
          heightFactor: .55,
          minHeight: 400,
          zoomAmt: .05,
          enableHero: true,
        ),
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
        heightFactor: .65,
        fractionalOffset: Offset(-.4, .2),
        zoomAmt: .25,
        dynamicHzOffset: -250,
      ),
      IllustrationPiece(
        fileName: 'foreground-right.png',
        alignment: Alignment.bottomCenter,
        initialOffset: Offset(20, 40),
        initialScale: .95,
        heightFactor: .6,
        fractionalOffset: Offset(.4, .2),
        zoomAmt: .1,
        dynamicHzOffset: 250,
      ),
      IllustrationPiece(
        fileName: 'top-left.png',
        alignment: Alignment.topLeft,
        initialScale: .9,
        initialOffset: Offset(-40, 60),
        heightFactor: .75,
        fractionalOffset: Offset(-.5, -.3),
        zoomAmt: .25,
        dynamicHzOffset: 100,
      ),
      IllustrationPiece(
        fileName: 'top-right.png',
        alignment: Alignment.topRight,
        initialOffset: Offset(20, 40),
        initialScale: .95,
        heightFactor: .85,
        fractionalOffset: Offset(.4, -.4),
        zoomAmt: .1,
        dynamicHzOffset: -100,
      ),

      // Stack(
      //   children: [
      //     Transform.scale(
      //       scale: 1 + config.zoom * .05,
      //       child: FractionalTranslation(
      //         translation: Offset(-.2 * (1 - curvedAnim), 0),
      //         child: BottomLeft(
      //           child: SizedBox(
      //             height: 500,
      //             child: FractionalTranslation(
      //               translation: Offset(-.4, .15),
      //               child: Image.asset('$assetPath/foreground-left.png', opacity: anim, fit: BoxFit.cover),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Transform.scale(
      //       scale: 1 + config.zoom * .03,
      //       child: FractionalTranslation(
      //         translation: Offset(.2 * (1 - curvedAnim), 0),
      //         child: BottomRight(
      //           child: SizedBox(
      //             height: 350,
      //             child: FractionalTranslation(
      //               translation: Offset(.35, .2),
      //               child: Image.asset('$assetPath/foreground-right.png', opacity: anim, fit: BoxFit.cover),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Transform.scale(
      //       scale: 1 + config.zoom * .25,
      //       child: FractionalTranslation(
      //         translation: Offset(-.2 * (1 - curvedAnim), 0),
      //         child: TopLeft(
      //           child: SizedBox(
      //             height: 600,
      //             child: FractionalTranslation(
      //               translation: Offset(-.3, -.45),
      //               child: Image.asset('$assetPath/top-left.png', opacity: anim, fit: BoxFit.cover),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Transform.scale(
      //       scale: 1 + config.zoom * .2,
      //       child: FractionalTranslation(
      //         translation: Offset(.2 * (1 - curvedAnim), 0),
      //         child: TopRight(
      //           child: SizedBox(
      //             height: 700,
      //             child: FractionalTranslation(
      //               translation: Offset(.2, -.35),
      //               child: Image.asset('$assetPath/top-right.png', opacity: anim, fit: BoxFit.cover),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    ];
  }
}
