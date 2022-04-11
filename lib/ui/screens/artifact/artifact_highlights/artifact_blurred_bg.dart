import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/gradient_container.dart';

/// Blurry image background for the Artifact Highlights view. Contains horizontal and vertical gradients that stack overtop the blended image.
class ArtifactBlurredBg extends StatelessWidget {
  const ArtifactBlurredBg({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    Color gradientColor = context.colors.greyStrong.withOpacity(0.6);

    if (url.isEmpty) {
      return Container(
        color: context.colors.greyStrong,
      );
    }
    return Container(
      decoration: BoxDecoration(
        // Image
        image: DecorationImage(
          image: CachedNetworkImageProvider(url),
          fit: BoxFit.cover,
        ),
      ),
      child: VtGradient(
        // Vertical gradient from top down.
        [gradientColor, gradientColor, Colors.white, Colors.white],
        const [0.0, 0.1, 0.8, 1.0],
        blendMode: BlendMode.multiply,
        child: HzGradient(
          // Horizontal gradient on edges of screen.
          [gradientColor, Colors.white, Colors.white, gradientColor],
          const [0.0, 0.05, 0.95, 1.0],
          blendMode: BlendMode.multiply,
          child: BackdropFilter(
            // Blur effect
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
