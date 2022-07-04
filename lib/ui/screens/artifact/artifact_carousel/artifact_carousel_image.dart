import 'dart:math' as math;

import 'package:image_fade/image_fade.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/highlights_data.dart';

class ArtifactCarouselImage extends StatelessWidget {
  const ArtifactCarouselImage({
    Key? key,
    required this.index,
    required this.currentPage,
    required this.artifact,
    required this.viewportFraction,
    required this.bottomPadding,
    required this.maxWidth,
    required this.maxHeight,
    required this.onPressed,
  }) : super(key: key);
  final HighlightsData artifact;
  final int index;
  final double currentPage;
  final double viewportFraction;
  final double bottomPadding;
  final double maxWidth;
  final double maxHeight;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBtn.basic(
      semanticLabel: '${artifact.title} ${artifact.date}',
      onPressed: onPressed,
      child: _ImagePreview(
        image: NetworkImage(artifact.imageUrlSmall),
        viewportFraction: viewportFraction,
        bottomPadding: bottomPadding,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        offsetAmt: currentPage - index.toDouble(),
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview(
      {Key? key,
      required this.image,
      required this.offsetAmt,
      required this.bottomPadding,
      required this.maxWidth,
      required this.maxHeight,
      required this.viewportFraction})
      : super(key: key);
  final ImageProvider image;
  final double offsetAmt;
  final double viewportFraction;
  final double bottomPadding;
  final double maxWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    // Additional scale of the main page, making it larger than the others.
    const double mainPageScaleFactor = 0.40;

    // Additional Y scale of the main page, making it elongated.
    const double mainPageScaleFactorY = -0.13;

    // Border variables
    const double borderPadding = 4.0;
    const double borderWidth = 1.0;

    // Base scale units that we can treat like pixels.
    double baseWidthScale = 1 / context.widthPx;
    double baseHeightScale = 1 / context.heightPx;

    // Size of the pages themselves.
    double pageWidth = baseWidthScale * maxWidth * 0.65;
    double pageHeight = baseHeightScale * maxWidth * 0.45;

    // Get the current page offset value compared to other pages. -1 is left, 0 is middle, 1 is right, etc.
    // Note: This value can be in between whole numbers, like 0.25 and -0.75.
    double pageOffset = math.max(-2, math.min(2, offsetAmt));

    // Add a scale-up to the main page.
    double midPageScaleUp = (1 - math.min(1, pageOffset.abs())) * mainPageScaleFactor;
    double midPageScaleUpY = (1 - math.min(1, pageOffset.abs())) * mainPageScaleFactorY;

    // Calculate the offset positions of the side elements.
    double xOffsetPad = (context.widthPx - maxWidth);
    // Use cube of pageOffset to create a loop-around effect.
    double xOffsetFactor = pageOffset;
    // Use absolute value of offset so images always move down.
    double yOffsetFactor = pageOffset.abs();

    if (pageOffset >= -1 && pageOffset <= 1) {
      // Create an offset factor using sin/cos to ease.
      xOffsetFactor = pageOffset - math.sin(pageOffset * math.pi) / 3;
      yOffsetFactor = 1 - math.cos(pageOffset * math.pi / 2.0).abs();
    } else {
      // Apply an opacity to elements beyond -1 to 1 offset to create a fadeout.
      xOffsetFactor = pageOffset * pageOffset * (pageOffset < 0 ? -1 : 1);
    }

    // Multiply the offset factors with the width/height scale to convert them to fractionals.
    double xOffset = xOffsetFactor * (baseWidthScale * xOffsetPad);
    double yOffset = yOffsetFactor * ((baseHeightScale / 2) * (maxWidth / 2));

    // Apply a vertical offset based on the bottom padding provided. This includes half the element width.
    double bottomPadding = (baseHeightScale / 2) * (maxHeight * 2 - (maxWidth / 2));

    double widthFactor = pageWidth + midPageScaleUp;
    double heightFactor = pageHeight + midPageScaleUp + midPageScaleUpY;

    // Scale box for sizing. Uses both the element scale and the element Y scale.
    return FractionalTranslation(
      // Move the pages around before scaling, as scaling will directly affect their translation.
      translation: Offset(xOffset, yOffset - bottomPadding),
      child: FractionallySizedBox(
        // Scale the elements according to whether they are on the sides or middle.
        alignment: Alignment.bottomCenter,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        // Translation box for positioning.
        child: Container(
          // Add an outer border with the rounded ends.
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: $styles.colors.offWhite, width: borderWidth),
            borderRadius: BorderRadius.all(Radius.circular(999)),
          ),

          child: Padding(
            padding: EdgeInsets.all(borderPadding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: ImageFade(
                  image: image,
                  fit: BoxFit.cover,
                  placeholder: ColoredBox(color: $styles.colors.greyMedium.withOpacity(0.75))),
            ),
          ),
        ),
      ),
    );
  }
}
