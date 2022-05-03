import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/collectibles_logic.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/ui/common/cards/opening_card.dart';
import 'package:wonders/ui/screens/collectible_found/collectible_found_screen.dart';

class CollectibleItem extends StatelessWidget with GetItMixin {
  CollectibleItem(this.collectible, {this.size = 64.0, Key? key}) : super(key: key) {
    // pre-fetch the image, so it's ready if we show the collectible found screen.
    _imageProvider = CachedNetworkImageProvider(collectible.imageUrlSmall);
    _imageProvider.resolve(ImageConfiguration()).addListener(ImageStreamListener((_, __) {}));
  }

  final CollectibleData collectible;
  final double size;
  late final CachedNetworkImageProvider _imageProvider;

  @override
  Widget build(BuildContext context) {
    final states = watchX((CollectiblesLogic c) => c.statesById);
    bool isLost = states[collectible.id] == CollectibleState.lost;
    // Use an OpeningCard to let the collectible smoothly collapse its size once it has been found
    return OpeningCard(
      isOpen: isLost,
      // SB: In order for the collapse animation to run properly, we must return a non-zero height or width. Not sure why :)
      closedBuilder: (_) => SizedBox(width: .01, height: 0),
      openBuilder: (_) => BasicBtn(
        semanticLabel: 'collectible item',
        onPressed: () => _handleTap(context),
        child: Hero(
          tag: 'collectible_icon_${collectible.id}',
          child: Image(
            image: collectible.icon,
            width: size,
            height: size,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) async {
    Duration duration = context.read<AppStyle>().times.fast;
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => CollectibleFoundScreen(collectible: collectible, imageProvider: _imageProvider),
        transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
        transitionDuration: duration,
        reverseTransitionDuration: duration,
        opaque: false,
        fullscreenDialog: true,
      ),
    );
    // wait to update the state, to ensure the hero works properly:
    await Future.delayed(duration);
    collectiblesLogic.updateState(collectible.id, CollectibleState.discovered);
  }
}
