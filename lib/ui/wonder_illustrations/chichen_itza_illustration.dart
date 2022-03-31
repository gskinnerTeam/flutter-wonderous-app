import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/wonder_illustrations/paint_textures.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration_builder.dart';
import 'package:wonders/ui/wonder_illustrations/wonder_illustration_config.dart';

class ChichenItzaIllustration extends StatelessWidget {
  const ChichenItzaIllustration({Key? key, required this.config}) : super(key: key);
  final WonderIllustrationConfig config;

  final Color _fgColor = const Color(0xFF174126);
  @override
  Widget build(BuildContext context) {
    return WonderIllustrationBuilder(
        config: config,
        bgBuilder: (_, anim) {
          return [
            Container(color: Color(0xfffbe7cc)),
            Positioned.fill(child: RollerPaint2(_fgColor.withOpacity(.2), scale: 1.3)),
            Center(
              child: Transform.translate(
                offset: Offset(100, -100),
                child: ClipRect(
                  child: Image.asset('assets/images/chichen_itza/sun.png')
                      .gTweener
                      .copyWith(curve: Curves.easeOut, duration: context.times.med)
                      .move(from: Offset(0, 60)),
                ),
              ),
            ),
          ];
        },
        mgBuilder: (_, anim) {
          return [
            Center(
              child: Hero(
                tag: 'chichen',
                child: Transform.scale(scale: 1.3, child: Image.asset('assets/images/chichen_itza/pyramid.png')),
              ),
            ),
          ];
        },
        fgBuilder: (context, anim) {
          final curvedAnim = Curves.easeOut.transform(anim.value);
          return [
            Transform.translate(
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
            )
          ];
        });
  }
}
