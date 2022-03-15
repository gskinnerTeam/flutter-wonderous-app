import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/transition_in_out_builder.dart';
import 'package:wonders/ui/common/wonder_illustrations.dart';
import 'package:wonders/ui/screens/home/wonders_home_screen.dart';

/// Background
class MachuPicchuBg extends StatelessWidget {
  const MachuPicchuBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(color: Colors.blue);
}

/// Midground
class MachuPicchuMg extends StatelessWidget {
  const MachuPicchuMg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => WonderIllustration(WonderType.machuPicchu);
}

/// Foreground
class MachuPicchuFg extends HomeParallaxLayer {
  const MachuPicchuFg({Key? key, required bool isShowing}) : super(key: key, isShowing: isShowing);

  @override
  Widget build(BuildContext context) {
    return TransitionInOutBuilder(
      isShowing: isShowing,
      builder: (_, anim) => Transform.translate(
        offset: Offset(0, (1 - anim.value) * 200),
        child: Stack(children: const [
          BottomLeft(child: FlutterLogo(size: 200)),
          BottomRight(child: FlutterLogo(size: 200)),
        ]),
      ),
    );
  }
}
