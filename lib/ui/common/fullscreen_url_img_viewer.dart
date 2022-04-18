import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';

class FullscreenUrlImgViewer extends StatelessWidget {
  const FullscreenUrlImgViewer({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.greyStrong,
      child: Stack(
        children: [
          Positioned.fill(
              child: InteractiveViewer(
            child: Hero(
              tag: url,
              child: CachedNetworkImage(
                imageUrl: url,
              ),
            ),
          )),
          TopRight(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(context.insets.sm),
                child: CircleBtn(
                  bgColor: context.colors.greyStrong,
                  onPressed: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close, color: context.colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
