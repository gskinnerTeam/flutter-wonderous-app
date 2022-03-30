import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/transition_in_out_builder.dart';
import 'package:wonders/ui/common/wonder_illustrations.dart';
import 'package:wonders/ui/screens/home/wonder_layers/paint_textures.dart';
import 'package:wonders/ui/screens/home/wonders_home_screen.dart';

final chichenItzaHomeLayers = WonderHomeLayersConfig(
  wonders.byType(WonderType.chichenItza),
  bg: _ChichenBg(),
  mg: _ChichenMg(),
  fgBuilder: (isShowing) => _ChichenFg(isShowing: isShowing),
  fgColor: Color(0xFF174126),
);

/// Background
class _ChichenBg extends StatelessWidget {
  const _ChichenBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Color(0xfffbe7cc)),
        Positioned.fill(child: RollerPaint2(chichenItzaHomeLayers.fgColor.withOpacity(.2), scale: 1.3)),
        Center(
          child: Transform.translate(
            offset: Offset(100, -150),
            child: ClipRect(
              child: Image.asset('assets/images/chichen_itza/sun.png')
                  .gTweener
                  .copyWith(curve: Curves.easeOut, duration: context.times.med)
                  .move(from: Offset(0, 60)),
            ),
          ),
        )
      ],
    );
  }
}

/// Midground
class _ChichenMg extends StatelessWidget {
  const _ChichenMg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Transform.scale(
        scale: 1.5,
        child: WonderIllustration(WonderType.chichenItza),
      );
}

/// Foreground
class _ChichenFg extends ShowableLayer {
  const _ChichenFg({Key? key, required bool isShowing}) : super(key: key, isShowing: isShowing);

  @override
  Widget build(BuildContext context) {
    return TransitionInOutBuilder(
      isShowing: isShowing,
      builder: (_, anim) {
        final curvedAnim = Curves.easeOut.transform(anim.value);
        return Transform.translate(
          offset: Offset(0, 60 + (1 - curvedAnim) * 50),
          child: FadeTransition(
            opacity: anim,
            child: Stack(children: [
              BottomLeft(
                child: Transform.translate(
                  offset: Offset(-70, -140),
                  child: Image.asset('assets/images/chichen_itza/agave-left.png'),
                ),
              ),
              BottomRight(
                child: Transform.translate(
                  offset: Offset(70, -170),
                  child: Transform.scale(
                    scale: 1.1,
                    child: Image.asset('assets/images/chichen_itza/agave-right.png'),
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
