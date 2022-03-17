import 'package:gtween/gtween.dart';
import 'package:wonders/common_libs.dart';

/// An overlay with a transparent cutout in the middle.
/// When index changes, the box animates its size for a nice effect
class AnimatedCutoutOverlay extends StatelessWidget {
  const AnimatedCutoutOverlay(
      {Key? key, required this.child, required this.cutoutSize, required this.animationKey, this.duration})
      : super(key: key);
  final Widget child;
  final Size cutoutSize;
  final Key animationKey;
  final Duration? duration;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        GTweener(
          [GCustom(builder: _buildAnimatedCutout)],
          key: animationKey,
          curve: Curves.easeOut,
          duration: duration,
          autoPlay: false,
          onInit: (t) => t.animation.forward().then((_) => t.animation.reverse()),
          child: IgnorePointer(child: Container(color: Colors.black.withOpacity(.6))),
        )
      ],
    );
  }

  /// Scales from 1 --> (1 - zoomAmt) --> 1
  Widget _buildAnimatedCutout(Widget child, Animation<double> anim) {
    const zoomAmt = .15;
    final size = cutoutSize * (1 - zoomAmt * anim.value);
    return ClipPath(clipper: _CutoutClipper(size), child: child);
  }
}

class _CutoutClipper extends CustomClipper<Path> {
  _CutoutClipper(this.cutoutSize);
  final Size cutoutSize;

  @override
  Path getClip(Size size) {
    double padX = (size.width - cutoutSize.width) / 2;
    double padY = (size.height - cutoutSize.height) / 2;
    return Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()
        ..addRRect(RRect.fromLTRBR(padX, padY, size.width - padX, size.height - padY, Radius.circular(6)))
        ..close(),
    );
  }

  @override
  bool shouldReclip(_CutoutClipper oldClipper) => oldClipper.cutoutSize != cutoutSize;
}
