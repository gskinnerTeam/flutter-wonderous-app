import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';

class ArtifactCarouselImage extends StatelessWidget {
  const ArtifactCarouselImage(
      {Key? key,
      required this.index,
      required this.currentPage,
      required this.artifact,
      required this.viewportFraction,
      this.onClick,
      this.borderOnly = false})
      : super(key: key);
  final void Function(int index)? onClick;
  final ArtifactData artifact;
  final int index;
  final double currentPage;
  final double viewportFraction;
  final bool borderOnly;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onClick?.call(index),
        child: CachedNetworkImage(
          // Show immediately; don't delay the appearance on the sides.
          fadeInDuration: context.times.fast,
          fadeOutDuration: context.times.fast,
          imageUrl: artifact.image,
          imageBuilder: (context, imageProvider) => _ImagePreview(
            image: imageProvider,
            heroTag: artifact.image,
            viewportFraction: viewportFraction,
            offsetAmt: currentPage - index.toDouble(),
          ),
        ),
      );
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview(
      {Key? key, required this.image, required this.offsetAmt, required this.heroTag, required this.viewportFraction})
      : super(key: key);
  final ImageProvider image;
  final double offsetAmt;
  final double viewportFraction;
  final String heroTag;
  @override
  Widget build(BuildContext context) {
    // Y scale of the size elements, compared to main.
    double sideElementYScale = 0.65;

    // Shrink factor of the side elements, compared to main.
    double sideElementScale = 0.65;

    // Scale of the X position offset.
    const double offsetScrollXScale = 0.3;
    // Scale of the Y position offset.
    const double offsetScrollYScale = 0.8;

    // Border variables
    const double borderPadding = 4.0;
    const double borderWidth = 1.0;

    // Calculated variables.
    const double elementWidth = 150;
    double offset = math.max(-2, math.min(2, offsetAmt));
    double elementYScale =
        sideElementYScale + ((1 - sideElementYScale) - (math.min(1, offset.abs()) * (1 - sideElementYScale)));
    double elementScale =
        sideElementScale + ((1 - sideElementScale) - (math.min(1, offset.abs()) * (1 - sideElementScale)));

    // Calculate the offset positions of the side elements.
    double xOffset = math.asin(offset * math.pi / 4.0) * -offsetScrollXScale;
    double yOffset = (offset * offset) * offsetScrollYScale;

    // Scale box for sizing. Uses both the element scale and the element Y scale.
    return FractionallySizedBox(
      alignment: Alignment.bottomCenter,
      widthFactor: elementScale,
      heightFactor: elementScale * elementYScale,
      // Translation box for positioning.
      child: FractionalTranslation(
        translation: Offset(xOffset, yOffset),
        child: Container(
          // Add an outer border with the rounded ends.
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: context.colors.offWhite, width: borderWidth),
            borderRadius: BorderRadius.all(Radius.circular(elementWidth)),
          ),

          child: Padding(
            padding: EdgeInsets.all(borderPadding),
            child: Container(
              // Round the edges, but make a capsule rather than a circle by only setting to width.
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(elementWidth)),

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
      ),
    );
  }
}
