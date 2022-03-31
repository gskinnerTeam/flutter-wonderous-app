import 'package:wonders/common_libs.dart';

class PaintSpeckles extends StatelessWidget {
  const PaintSpeckles(this.color, {Key? key, this.scale = 1.5, this.flipX = false, this.flipY = false})
      : super(key: key);
  final Color color;
  final double scale;
  final bool flipX;
  final bool flipY;

  @override
  Widget build(BuildContext context) => Transform.scale(
      scaleX: scale * (flipX ? -1 : 1),
      scaleY: scale * (flipY ? -1 : 1),
      child: Image.asset('assets/images/speckles-white.png', fit: BoxFit.cover, color: color));
}

class RollerPaint1 extends StatelessWidget {
  const RollerPaint1(this.color, {Key? key, this.scale = 1.5, this.flipX = false, this.flipY = false})
      : super(key: key);
  final Color color;
  final double scale;
  final bool flipX;
  final bool flipY;

  @override
  Widget build(BuildContext context) => Transform.scale(
      scaleX: scale * (flipX ? -1 : 1),
      scaleY: scale * (flipY ? -1 : 1),
      child: Image.asset('assets/images/roller-1-white.png', fit: BoxFit.cover, color: color));
}

class RollerPaint2 extends StatelessWidget {
  const RollerPaint2(this.color, {Key? key, this.scale = 1.5, this.flipX = false, this.flipY = false})
      : super(key: key);
  final Color color;
  final double scale;
  final bool flipX;
  final bool flipY;
  @override
  Widget build(BuildContext context) => Transform.scale(
        scaleX: scale * (flipX ? -1 : 1),
        scaleY: scale * (flipY ? -1 : 1),
        child: Image.asset('assets/images/roller-2-white.png', fit: BoxFit.cover, color: color),
      );
}
