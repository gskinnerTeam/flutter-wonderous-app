import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/collectibles_logic.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/ui/screens/collectible_found/collectible_found_screen.dart';

class CollectibleItem extends StatelessWidget with GetItMixin {
  CollectibleItem(this.collectible, {this.size = 64.0, Key? key}) : super(key: key) {
    // pre-fetch the image, so it's ready if we show the collectible found screen.
    imageProvider = CachedNetworkImageProvider(collectible.imageUrl);
    imageProvider.resolve(ImageConfiguration()).addListener(ImageStreamListener((_, __) {}));
  }

  final CollectibleData collectible;
  final double size;
  late final CachedNetworkImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    final states = watchX((CollectiblesLogic o) => o.states);
    if (states[collectible.id] != CollectibleState.lost) return SizedBox(width: size, height: size);
    return GestureDetector(
      onTap: () => _handleTap(context),
      child: Hero(tag: 'collectible_icon_${collectible.id}', child: _buildIcon()),
    );
  }

  void _handleTap(BuildContext context) {
    Duration duration = 300.ms;
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => CollectibleFoundScreen(collectible: collectible, imageProvider: imageProvider),
        transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
        transitionDuration: duration,
        reverseTransitionDuration: duration,
        opaque: false,
        fullscreenDialog: true,
      ),
    );
    // wait to update the state, to ensure the hero works properly:
    Future.delayed(duration).then((_) => collectiblesLogic.updateState(collectible.id, CollectibleState.discovered));
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
