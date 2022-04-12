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
    const double offsetScrollDistance = 2;
    // Scale of the elements, compared to max screen dimensions (maintains aspect ratio).
    double sideElementScale = 0.65;
    double mainElementScale = 0.35;

    // Border variables
    const double borderPadding = 4.0;
    const double borderWidth = 1.0;

    // Calculated variables.
    const double elementWidth = 150;
    double offset = math.max(-1, math.min(1, offsetAmt));
    double elementScale = sideElementScale + (mainElementScale - (math.min(1, offset.abs()) * mainElementScale));

    double yOffset = math.asin((offset.abs()) * math.pi / 8.0) * offsetScrollDistance;

    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: elementScale,
      child: FractionalTranslation(
        translation: Offset(0, yOffset),
        child: Container(
          // Add an outer border with the rounded ends.
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: context.colors.bg, width: borderWidth),
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
