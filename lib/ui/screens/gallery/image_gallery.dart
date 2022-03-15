import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/wonder_illustrations.dart';

class ImageGalleryScreen extends StatelessWidget {
  const ImageGalleryScreen({Key? key, required this.type}) : super(key: key);
  final WonderType type;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 400,
          flexibleSpace: WonderIllustration(type),
        ),
        SliverToBoxAdapter(child: Placeholder(fallbackHeight: 2000))
      ],
    );
  }
}
