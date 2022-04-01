import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/unsplash_photo_data.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';

class UnsplashPhoto extends StatelessWidget {
  const UnsplashPhoto(this.id, {Key? key, this.fit = BoxFit.cover, required this.targetSize, this.showCredits = true})
      : super(key: key);
  final String id;
  final BoxFit fit;
  final num? targetSize;
  final bool showCredits;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UnsplashPhotoData?>(
        future: unsplash.getInfo(id),
        builder: (_, snapshot) {
          if (snapshot.hasData == false) return Container(); // Loading...
          String? url = snapshot.data?.getSizedUrl(targetSize?.round() ?? 600);
          return url == null
              ? _LoadError()
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(imageUrl: url, fit: fit, placeholder: (_, __) => Center(child: AppLoader())),
                    BottomCenter(
                      child: AnimatedOpacity(
                        opacity: showCredits ? 1 : 0,
                        duration: context.times.fast,
                        child: Container(
                          width: double.infinity,
                          color: Colors.black.withOpacity(.5),
                          padding: EdgeInsets.all(context.insets.xs),
                          //TODO: Add proper credits and apply for unsplash
                          child: Text('Photo by ${snapshot.data} on Unsplash',
                              style: context.style.text.caption.copyWith(color: context.colors.text)),
                        ),
                      ),
                    )
                  ],
                );
        });
  }
}

class _LoadError extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Icon(Icons.warning));
}
