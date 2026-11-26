part of '../timeline_screen.dart';

class _DashedDividerWithYear extends StatelessWidget {
  const _DashedDividerWithYear(this.year);
  final int year;

  /// At large text sizes the label's text scale is capped at this value so it stays clear of the event popup.
  static const double largeTextMaxScale = 2;

  /// The label's height at [largeTextMaxScale]; it sits directly above the dashed line.
  static double get largeTextHeight =>
      $styles.text.h2.fontSize! * ($styles.text.h2.height ?? 1.2) * largeTextMaxScale;

  @override
  Widget build(BuildContext context) {
    int yrGap = 10;
    final roundedYr = (year / yrGap).round() * yrGap;
    final bool largeText = MediaQuery.textScalerOf(context).scale(1) >= TimelineEventCard.stackedTextScale;
    Widget label = MergeSemantics(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${roundedYr.abs()}',
            style: $styles.text.h2.copyWith(
              color: $styles.colors.white,
              shadows: $styles.shadows.text,
            ),
          ),
          Gap($styles.insets.xs),
          Text(
            StringUtils.getYrSuffix(roundedYr),
            style: $styles.text.body.copyWith(
              color: Colors.white,
              shadows: $styles.shadows.textStrong,
            ),
          ),
          Gap($styles.insets.xs),
        ],
      ),
    );
    if (largeText) {
      // Cap the scale and keep the label within half the screen width, so it doesn't swamp the popup and timeline.
      label = MediaQuery.withClampedTextScaling(
        maxScaleFactor: largeTextMaxScale,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 2),
          child: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerRight, child: label),
        ),
      );
    }
    return Stack(
      children: [
        Center(child: DashedLine()),
        CenterRight(
          child: FractionalTranslation(
            translation: Offset(0, -.5),
            child: label,
          ),
        ),
      ],
    );
  }
}
