import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/ui/common/utils/page_routes.dart';

import 'package:wonders/ui/screens/collectibles/collectible_found_screen.dart';

class CollectibleItem extends StatelessWidget {
  const CollectibleItem(this.collectible, {this.size = 64.0, Key? key}) : super(key: key);

  final CollectibleData collectible;
  final double size;

  @override
  Widget build(BuildContext context) {
    // todo: possibly move this into page_routes

    handleTap() => Navigator.of(context).push(PageRouteBuilder(
          fullscreenDialog: true,
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 300),
          reverseTransitionDuration: Duration(milliseconds: 1),
          opaque: false,
          pageBuilder: (_, __, ___) => CollectibleFoundScreen(
            collectible: collectible,
          ),
        ));

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
