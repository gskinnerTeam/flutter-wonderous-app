import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/ui/screens/collectibles/collectible_found_screen.dart';

// todo: check collected state, and hide if appropriate.
// todo: convert to stateful and add a (delayed?) setState to update collected state

class CollectibleItem extends StatelessWidget {
  CollectibleItem(this.collectible, {this.size = 64.0, Key? key}) : super(key: key) {
    // pre-fetch the image, so it's ready if we show the collectible found screen.
    imageProvider = CachedNetworkImageProvider(collectible.imageUrl);
    imageProvider.resolve(ImageConfiguration()).addListener(ImageStreamListener((_, __){}));
  }

  final CollectibleData collectible;
  final double size;
  late final CachedNetworkImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    void handleTap() => Navigator.of(context).push(
          PageRouteBuilder(
            fullscreenDialog: true,
            barrierDismissible: true,
            transitionDuration: Duration(milliseconds: 300),
            reverseTransitionDuration: Duration(milliseconds: 1),
            opaque: false,
            pageBuilder: (_, __, ___) => CollectibleFoundScreen(
              collectible: collectible,
              imageProvider: imageProvider,
            ),
          ),
        );

    return GestureDetector(onTap: handleTap, child: Hero(tag: 'collectible_icon', child: _buildIcon()));
  }

  Widget _buildIcon() {
    return Image(
      image: collectible.icon,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
