import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/gradient_container.dart';

class ArtifactBlurredBg extends StatelessWidget {
  const ArtifactBlurredBg({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
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
        [context.colors.greyStrong, context.colors.greyStrong, Colors.white],
        const [0.0, 0.2, 1.0],
        blendMode: BlendMode.multiply,
        child: HzGradient(
          // Horizontal gradient on edges of screen.
          [context.colors.greyStrong, Colors.white, Colors.white, context.colors.greyStrong],
          const [0.0, 0.05, 0.95, 1.0],
          blendMode: BlendMode.multiply,
          child: BackdropFilter(
            // Blur effect
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
