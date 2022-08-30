import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/fade_color_transition.dart';
import 'package:wonders/ui/wonder_illustrations/common/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/common/wonder_hero.dart';
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
      Align(
        alignment: config.shortMode ? Alignment(.5, -1.5) : Alignment(.5, -.75),
        child: FractionalTranslation(
          translation: Offset(0, .5 * anim.value),
          child: WonderHero(
            config,
            'christ-sun',
            child: Transform.scale(
              scale: config.shortMode ? 1.4 : 1.6,
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
      ClipRect(
        child: Transform.scale(
          scale: 1 + config.zoom * .2,
          child: FractionalTranslation(
            translation: Offset(0, config.shortMode ? .5 : .2),
            child: BottomCenter(
              child: FractionallySizedBox(
                heightFactor: config.shortMode ? 1.5 : 1.2,
                child: WonderHero(
                  config,
                  'christ-mg',
                  child: Image.asset(
                    '$assetPath/redeemer.png',
                    opacity: anim,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    final curvedAnim = Curves.easeOut.transform(anim.value);
    return [
      Stack(
        children: [
          Transform.scale(
            scale: 1 + config.zoom * .15,
            child: FractionalTranslation(
              translation: Offset(-.2 * (1 - curvedAnim), 0),
              child: BottomLeft(
                child: FractionallySizedBox(
                  widthFactor: 1.5,
                  child: FractionalTranslation(
                    translation: Offset(-.25, .03),
                    child: Image.asset('$assetPath/foreground-left.png', opacity: anim, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          Transform.scale(
            scale: 1 + config.zoom * .3,
            child: FractionalTranslation(
              translation: Offset(.2 * (1 - curvedAnim), 0),
              child: BottomRight(
                child: FractionallySizedBox(
                  widthFactor: 1.5,
                  child: FractionalTranslation(
                    translation: Offset(.3, .2),
                    child: Image.asset('$assetPath/foreground-right.png', opacity: anim, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }
}
