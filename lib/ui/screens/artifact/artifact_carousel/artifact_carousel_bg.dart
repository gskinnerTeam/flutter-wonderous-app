import 'dart:ui';

import 'package:image_fade/image_fade.dart';
import 'package:wonders/common_libs.dart';

/// Blurry image background for the Artifact Highlights view. Contains horizontal and vertical gradients that stack overtop the blended image.
class ArtifactCarouselBg extends StatelessWidget {
  const ArtifactCarouselBg({Key? key, this.url}) : super(key: key);
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.25,
      alignment: Alignment(0, 0.8),
      child: Stack(children: [
        Positioned.fill(child: ImageFade(image: url == null ? null : NetworkImage(url!), fit: BoxFit.cover)),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(color: context.colors.greyMedium.withOpacity(0.66)),
          ),
        ),
      ]),
    );
  }
}
