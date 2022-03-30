import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/blend_mask.dart';
import 'package:wonders/ui/common/transition_in_out_builder.dart';
import 'package:wonders/ui/common/wonder_illustrations.dart';
import 'package:wonders/ui/screens/home/wonder_layers/paint_textures.dart';
import 'package:wonders/ui/screens/home/wonders_home_screen.dart';

final tajMahalHomeLayers = WonderHomeLayersConfig(
  wonders.byType(WonderType.tajMahal),
  bg: _TajBg(),
  mg: _TajMg(),
  fgBuilder: (isShowing) => TajFg(isShowing: isShowing),
  fgColor: Color(0xFF80433F),
);

/// Background
class _TajBg extends StatelessWidget {
  const _TajBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Color(0xff8b4641)),
        Positioned.fill(
          child: BlendMask(
            blendModes: const [BlendMode.overlay],
            opacity: .3,
            child: FractionalTranslation(
              translation: Offset(.2, .1),
              child: RollerPaint1(Colors.white, scale: 2),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(-150, -310),
            child: GTweener(
              [GMove(from: Offset(-100, 20))],
              duration: context.times.med,
              curve: Curves.easeOut,
              child: Image.asset('assets/images/taj_mahal/sun.png'),
            ),
          ),
        )
      ],
    );
  }
}

/// Mid-ground
class _TajMg extends StatelessWidget {
  const _TajMg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double size = 320;
    return Transform.translate(
      offset: Offset(0, -size * .1),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(child: SizedBox(width: size, child: WonderIllustration(WonderType.tajMahal))),
          Center(
            child: Transform.translate(
              offset: Offset(0, size * .22),
              child: UnconstrainedBox(
                child: SizedBox(
                  height: size,
                  child: Image.asset('assets/images/taj_mahal/wall.png', fit: BoxFit.fitHeight),
                ),
              ),
            ),
          ),
          Center(
            child: UnconstrainedBox(
              child: SizedBox(
                height: size * 1,
                child: FractionalTranslation(
                  translation: Offset(0, 1.13),
                  child: Image.asset('assets/images/taj_mahal/pool.png', fit: BoxFit.fitHeight),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Foreground
class TajFg extends ShowableLayer {
  const TajFg({Key? key, required bool isShowing}) : super(key: key, isShowing: isShowing);

  @override
  Widget build(BuildContext context) {
    return TransitionInOutBuilder(
      isShowing: isShowing,
      builder: (_, anim) {
        final curvedAnim = Curves.easeOut.transform(anim.value);
        return FadeTransition(
          opacity: anim,
          child: Stack(children: [
            BottomLeft(
              child: FractionalTranslation(
                translation: Offset(-.3 * (1 - curvedAnim), 0),
                child: Transform.rotate(
                  angle: pi * -.1 * (1 - curvedAnim),
                  child: FractionalTranslation(
                    translation: Offset(-.4, -.3),
                    child: Image.asset('assets/images/taj_mahal/mangos-left.png'),
                  ),
                ),
              ),
            ),
            BottomRight(
              child: FractionalTranslation(
                translation: Offset(.3 * (1 - curvedAnim), 0),
                child: Transform.rotate(
                  angle: pi * .1 * (1 - curvedAnim),
                  child: FractionalTranslation(
                    translation: Offset(.5, -.25),
                    child: Image.asset('assets/images/taj_mahal/mangos-right.png'),
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
