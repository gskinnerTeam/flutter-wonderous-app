import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/collectibles_logic.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/ui/common/cards/opening_card.dart';
import 'package:wonders/ui/screens/collectible_found/collectible_found_screen.dart';

class CollectibleItem extends StatelessWidget with GetItMixin {
  CollectibleItem(this.collectible, {this.size = 64.0, Key? key}) : super(key: key) {
    // pre-fetch the image, so it's ready if we show the collectible found screen.
    _imageProvider = NetworkImage(collectible.imageUrlSmall);
    _imageProvider.resolve(ImageConfiguration()).addListener(ImageStreamListener((_, __) {}));
  }

  final CollectibleData collectible;
  final double size;
  late final ImageProvider _imageProvider;

  @override
  Widget build(BuildContext context) {
    final states = watchX((CollectiblesLogic c) => c.statesById);
    bool isLost = states[collectible.id] == CollectibleState.lost;
    // Use an OpeningCard to let the collectible smoothly collapse its size once it has been found
    return OpeningCard(
      isOpen: isLost,
      // Note: In order for the collapse animation to run properly, we must return a non-zero height or width.
      closedBuilder: (_) => SizedBox(width: 1, height: 0),
      openBuilder: (_) => AppBtn.basic(
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
    final screen = CollectibleFoundScreen(collectible: collectible, imageProvider: _imageProvider);
    appLogic.showFullscreenDialogRoute(context, screen);

    // wait to update the state, to ensure the hero works properly:
    await Future.delayed($styles.times.pageTransition);
    collectiblesLogic.updateState(collectible.id, CollectibleState.discovered);
  }
}
