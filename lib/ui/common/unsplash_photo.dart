import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/unsplash_photo_data.dart';

class UnsplashPhoto extends StatelessWidget {
  const UnsplashPhoto(this.id, {Key? key, this.fit = BoxFit.cover, required this.size, this.showCredits = false})
      : super(key: key);
  final String id;
  final BoxFit fit;
  final UnsplashPhotoSize size;
  final bool showCredits;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AppImage(
          image: NetworkImage(UnsplashPhotoData.getSelfHostedUrl(id, size)),
          fit: fit,
          progress: true,
          scale: 1,
        ),
      ],
    );
  }
}
