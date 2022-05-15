import 'package:image_fade/image_fade.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/unsplash_photo_data.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';

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
        ImageFade(
          image: NetworkImage(UnsplashPhotoData.getSelfHostedUrl(id, size)),
          fit: fit,
          loadingBuilder: (_, __, ___) => const Center(child: AppLoader()),
        ),
      ],
    );
  }
}
