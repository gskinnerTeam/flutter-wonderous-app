import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';

// TODO @ AG: The top portion of the images is not clickable.
//  This is because they exceed the bounds of their parent when using transform.scale + translate.
// A better approach with flutter is to use a large parent view (page), that uses internal padding to shrink things down...
//
class ArtifactCarouselImage extends StatelessWidget {
  const ArtifactCarouselImage(
      {Key? key,
      required this.index,
      required this.currentPage,
      required this.artifact,
      this.onClick,
      this.borderOnly = false})
      : super(key: key);
  final void Function(int index)? onClick;
  final ArtifactData artifact;
  final int index;
  final double currentPage;
  final bool borderOnly;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onClick?.call(index),
        child: FittedBox(
            child: CachedNetworkImage(
          // Show immediately; don't delay the appearance on the sides.
          fadeInDuration: context.times.fast,
          fadeOutDuration: context.times.fast,
          imageUrl: artifact.image,
          imageBuilder: (context, imageProvider) => _ImagePreview(
            image: imageProvider,
            heroTag: artifact.image,
            offsetAmt: currentPage - index.toDouble(),
          ),
        )),
      );
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({Key? key, required this.image, required this.offsetAmt, required this.heroTag})
      : super(key: key);
  final ImageProvider image;
  final double offsetAmt;
  final String heroTag;
  @override
  Widget build(BuildContext context) {
    const double offsetScrollDistance = 2;
    // Scale of the elements, compared to max screen dimensions (maintains aspect ratio).
    const double mainElementScale = 0.8;
    const double sideElementScale = 0.4;
    const double extraMiddleSpace = 0.5;
    // Horizontal offset of side elements
    const double hzSpacing = 20;
    // Vertical offset of side elements
    const double vtSpacing = 20;
    // Horizontal offset of whole carousel
    const double hzOffset = 0;
    // Vertical offset of the whole carousel.
    const double vtOffset = 20;
    // Translated spacing apart.
    const double spacing = 3.0 / 5.0;

    // Calculated variables.
    const double elementWidth = 50;
    double offset = math.max(-offsetScrollDistance, math.min(offsetScrollDistance, offsetAmt));
    double mainElementScaleUp =
        1 + (sideElementScale - (math.min(offsetScrollDistance, offset.abs()) * sideElementScale));

    double xAngle = math.asin((offset) * math.pi / 6.0);
    double yAngle = math.acos((offset.abs()) * math.pi / 6.0);
    return Transform(
      origin: Offset(elementWidth / 2, (elementWidth / 2) * mainElementScaleUp),

      transform: Matrix4.identity()
        ..translate(
          xAngle * (elementWidth * spacing) + (-hzSpacing * offset) + hzOffset,
          yAngle * (-elementWidth * spacing) + (vtSpacing * offset.abs()) + vtOffset,
        )
        ..scale((mainElementScale + extraMiddleSpace) - (offset.abs() * extraMiddleSpace)),

      // Inside the container, width and height determine aspect ratio
      child: Container(
        width: elementWidth,
        height: elementWidth * mainElementScaleUp,

        // Add an outer border with the rounded ends.
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: context.colors.bg, width: 0.3),
          borderRadius: BorderRadius.all(Radius.circular(elementWidth / 2)),
        ),
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Container(
            width: elementWidth,
            height: elementWidth * mainElementScaleUp,

            // Round the edges, but make a capsule rather than a circle by only setting to width.
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(elementWidth / 2)),

              // Display image
              image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(math.min(1, offset.abs())), // 0 = Colored, 1 = Black & White
                    BlendMode.saturation,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
