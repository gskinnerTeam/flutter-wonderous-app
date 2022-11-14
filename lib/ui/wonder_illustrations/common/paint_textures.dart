import 'package:wonders/common_libs.dart';

class IllustrationTexture extends StatelessWidget {
  const IllustrationTexture(this.path,
      {Key? key, this.scale = 1, this.color, this.flipX = false, this.flipY = false, this.opacity})
      : super(key: key);
  final Color? color;
  final double scale;
  final bool flipX;
  final bool flipY;
  final String path;
  final Animation<double>? opacity;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: opacity ?? AlwaysStoppedAnimation(1),
        builder: (context, child) => ClipRect(
          child: Transform.scale(
              scaleX: scale * (flipX ? -1 : 1),
              scaleY: scale * (flipY ? -1 : 1),
              child: Image.asset(path, fit: BoxFit.cover, color: color, opacity: opacity, cacheWidth: 1024)),
        ),
      );
}
