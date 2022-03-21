import 'package:wonders/common_libs.dart';

class WallpaperPreview extends StatelessWidget {
  const WallpaperPreview({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: context.widthPx / context.heightPx,
      child: Container(
        color: Colors.red.shade900,
        child: child,
      ),
    );
  }
}
