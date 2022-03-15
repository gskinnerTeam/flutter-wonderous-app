import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/transition_in_out_builder.dart';
import 'package:wonders/ui/common/wonder_illustrations.dart';
import 'package:wonders/ui/screens/home/wonders_home_screen.dart';

/// Background
class PetraBg extends StatelessWidget {
  const PetraBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(color: Colors.red);
}

/// Midground
class PetraMg extends StatelessWidget {
  const PetraMg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => WonderIllustration(WonderType.petra);
}

/// Foreground
class PetraFg extends HomeParallaxLayer {
  const PetraFg({Key? key, required bool isShowing}) : super(key: key, isShowing: isShowing);

  @override
  Widget build(BuildContext context) {
    return TransitionInOutBuilder(
      isShowing: isShowing,
      builder: (_, anim) => Transform.translate(
        offset: Offset(0, (1 - anim.value) * 100),
        child: Stack(children: const [
          BottomLeft(child: FlutterLogo(size: 100)),
          BottomRight(child: FlutterLogo(size: 100)),
        ]),
      ),
    );
  }
}
