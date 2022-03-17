import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import '../../common/swipeable_image_grid/swipeable_image_grid.dart';

class ImageGalleryScreen extends StatelessWidget {
  const ImageGalleryScreen({Key? key, required this.type}) : super(key: key);
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        children: [
          SwipeableImageGrid(),
          BackButton(color: context.colors.bg),
        ],
      ),
    );
  }
}
