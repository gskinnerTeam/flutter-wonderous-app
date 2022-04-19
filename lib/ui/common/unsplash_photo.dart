import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/unsplash_photo_data.dart';
import 'package:wonders/ui/common/app_loading_error.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/common/unsplash_photo_credits_row.dart';

class UnsplashPhoto extends StatelessWidget {
  const UnsplashPhoto(this.id, {Key? key, this.fit = BoxFit.cover, required this.size, this.showCredits = false})
      : super(key: key);
  final String id;
  final BoxFit fit;
  final UnsplashPhotoSize size;
  final bool showCredits;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UnsplashPhotoData?>(
        future: unsplashLogic.getInfo(id),
        builder: (_, snapshot) {
          if (snapshot.hasData == false) return Container(); // Loading...
          UnsplashPhotoData? data = snapshot.data;
          String? url = data?.getSizedUrl(size);
          if (data == null || url == null) return AppLoadError();
          //debugPrint('showingImage: $url');
          return Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: url,
                fit: fit,
                placeholder: (_, __) => Center(child: AppLoader()),
                cacheManager: CacheManager(Config('unsplash', maxNrOfCacheObjects: 200, stalePeriod: 1.hours)),
              ),
              if (showCredits) ...[
                BottomCenter(
                  child: AnimatedOpacity(
                    opacity: showCredits ? 1 : 0,
                    duration: context.times.fast,
                    child: UnsplashPhotoCreditsRow(data),
                  ),
                )
              ]
            ],
          );
        });
  }
}
