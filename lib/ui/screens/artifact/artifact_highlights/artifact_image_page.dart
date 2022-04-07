import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'dart:math' as math;

class ArtifactImagePage extends StatelessWidget {
  const ArtifactImagePage(
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
  Widget build(BuildContext context) {
    // TWEAKABLE: Setup some repeated parameters so it's easy to edit.
    double offsetScrollDistance = 2;
    // Scale of the elements, compared to max screen dimensions (maintains aspect ratio).
    double elementScale = 0.8;
    // Extra scale for the middle element.
    double elementScaleMidAdd = 0.5;
    // Height scale to make middle element like a capsule.
    double mainElementHeightScale = 0.4;
    // Horizontal offset of side elements
    double horiSpacing = 20;
    // Horizontal offset of whole carousel
    double horiOffset = 0;
    // Vertical offset of side elements
    double vertSpacing = 20;
    // Vertical offset of the whole carousel.
    double vertOffset = 20;
    // Translated spacing apart.
    double spacing = 3.0 / 5.0;

    // Calculated variables.
    double elementWidth = 50;
    double offset =
        math.max(-offsetScrollDistance, math.min(offsetScrollDistance, currentPage - double.parse(index.toString())));
    double mainElementScaleUp =
        1 + (mainElementHeightScale - (math.min(offsetScrollDistance, offset.abs()) * mainElementHeightScale));

    double xAngle = math.asin((offset) * math.pi / 6.0);
    double yAngle = math.acos((offset.abs()) * math.pi / 6.0);

    // Show a cached network image.
    Widget component = CachedNetworkImage(
      // Show immediately; don't delay the appearance on the sides.
      fadeOutDuration: const Duration(milliseconds: 200),
      fadeInDuration: const Duration(milliseconds: 200),

      // Image URL ref.
      imageUrl: artifact.image,

      // Build the image previewer.
      imageBuilder: (context, imageProvider) {
        // Transform object to animate pages.
        return Transform(
          origin: Offset(elementWidth / 2, (elementWidth / 2) * mainElementScaleUp),

          transform: Matrix4.identity()
            ..translate(
              xAngle * (elementWidth * spacing) + (-horiSpacing * offset) + horiOffset,
              yAngle * (-elementWidth * spacing) + (vertSpacing * offset.abs()) + vertOffset,
            )
            ..scale((elementScale + elementScaleMidAdd) - (offset.abs() * elementScaleMidAdd)),

          // Inside the container, width and height determine aspect ratio
          child: Container(
            width: elementWidth,
            height: elementWidth * mainElementScaleUp,

            // Add an outer border with the rounded ends.
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                color: context.colors.bg,
                width: 0.3,
              ),
              borderRadius: BorderRadius.all(Radius.circular(elementWidth / 2)),
            ),
            child: Padding(
              // Padding for the border
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
                      image: imageProvider,
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
      },
    );

    return GestureDetector(
      onTap: () => onClick?.call(index),
      child: FittedBox(child: component),
    );
  }
}
