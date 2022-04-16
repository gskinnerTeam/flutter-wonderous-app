import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/platform_info.dart';
import 'package:wonders/logic/data/unsplash_photo_data.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';

class UnsplashPhoto extends StatelessWidget {
  const UnsplashPhoto(this.id, {Key? key, this.fit = BoxFit.cover, required this.targetSize, this.showCredits = false})
      : super(key: key);
  final String id;
  final BoxFit fit;
  final int targetSize;
  final bool showCredits;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UnsplashPhotoData?>(
        future: unsplashLogic.getInfo(id),
        builder: (_, snapshot) {
          if (snapshot.hasData == false) return Container(); // Loading...
          UnsplashPhotoData? data = snapshot.data;
          int imgSizePx = (PlatformInfo.dpi * targetSize).round();
          String? url = data?.getSizedUrl(imgSizePx);
          if (data == null || url == null) return _LoadError();
          return Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: url,
                fit: fit,
                placeholder: (_, __) => Center(child: AppLoader()),
              ),
              if (showCredits) ...[
                BottomCenter(
                  child: AnimatedOpacity(
                    opacity: showCredits ? 1 : 0,
                    duration: context.times.fast,
                    child: _UnsplashPhotoAttribution(data),
                  ),
                )
              ]
            ],
          );
        });
  }
}

class _UnsplashPhotoAttribution extends StatelessWidget {
  const _UnsplashPhotoAttribution(this.data, {Key? key}) : super(key: key);
  final UnsplashPhotoData data;

  @override
  Widget build(BuildContext context) {
    void handleUserNamePressed() => appLogic.showWebView(context, data.photographerUrl);
    void handleUnsplashPressed() => appLogic.showWebView(context, UnsplashPhotoData.unsplashUrl);

    final style = context.text.caption.copyWith(color: context.colors.white, height: 1);
    return Container(
      width: double.infinity,
      color: Colors.black.withOpacity(.5),
      child: Row(
        children: [
          Gap(context.insets.sm),
          Text('Photo by', style: style),
          TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  splashFactory: NoSplash.splashFactory,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: Text(data.ownerUsername, style: style.copyWith(fontWeight: FontWeight.bold)),
              onPressed: handleUserNamePressed),
          Text('on', style: style),
          TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                splashFactory: NoSplash.splashFactory,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text('Unsplash', style: style.copyWith(fontWeight: FontWeight.bold)),
              onPressed: handleUnsplashPressed),
        ],
      ),
    );
  }
}

class _LoadError extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Icon(Icons.warning));
}
