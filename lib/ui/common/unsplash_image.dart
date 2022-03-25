import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/unsplash_photo_data.dart';
import 'package:wonders/ui/common/app_loader.dart';

class UnsplashPhoto extends StatelessWidget {
  const UnsplashPhoto(this.id, {Key? key, this.fit = BoxFit.cover, required this.targetSize}) : super(key: key);
  final String id;
  final BoxFit fit;
  final int? targetSize;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UnsplashPhotoData?>(
        future: unsplash.getInfo(id),
        builder: (_, snapshot) {
          if (snapshot.hasData == false) return Container(); // Loading...
          String? url = snapshot.data?.getSizedUrl(targetSize);
          return url == null
              ? _LoadError()
              : CachedNetworkImage(imageUrl: url, fit: fit, placeholder: (_, __) => Center(child: AppLoader()));
        });
  }
}

class _LoadError extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Icon(Icons.warning));
}
