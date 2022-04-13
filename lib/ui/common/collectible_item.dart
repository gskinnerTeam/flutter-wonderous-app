
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/collectible_data.dart';

import 'package:wonders/ui/screens/collectibles/collectible_found_screen.dart';

class CollectibleItem extends StatelessWidget {
  final CollectibleData collectible;
  final double size;

  const CollectibleItem(this.collectible, {this.size=64.0, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          fullscreenDialog: true,
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 400),
          reverseTransitionDuration: Duration(milliseconds: 250),
          opaque: false,
          pageBuilder: (_, __, ___) => CollectibleFoundScreen(
            collectible: collectible,
          ),
        ));
      },
      child: Hero(tag: 'collectible', child: _buildIcon())
    );
  }

  Widget _buildIcon() {
    return Image(
      image: collectible.icon,
      width: size, height: size,
      fit: BoxFit.contain,
    );
  }
}

//https://stackoverflow.com/questions/44403417/hero-animation-with-an-alertdialog
//router.dart