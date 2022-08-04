import 'package:image_fade/image_fade.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';

//TODO: Add proper semantic label.
class FullscreenUrlImgViewer extends StatelessWidget {
  const FullscreenUrlImgViewer({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: $styles.colors.greyStrong,
      child: Stack(
        children: [
          Positioned.fill(
            child: Semantics(
              label: 'Full screen',
              container: true,
              image: true,
              child: ExcludeSemantics(
                child: InteractiveViewer(
                  child: Hero(
                    tag: url,
                    child: ImageFade(
                      image: NetworkImage(url),
                      fit: BoxFit.contain,
                      loadingBuilder: (_, __, ___) => const Center(child: AppLoader()),
                    ),
                  ),
                ),
              ),
            ),
          ),
          BackBtn.close().safe(),
        ],
      ),
    );
  }
}
