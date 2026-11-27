part of '../timeline_screen.dart';

class _DashedDividerWithYear extends StatelessWidget {
  const _DashedDividerWithYear(this.year);
  final int year;

  /// The label is already display-sized, so it stops growing sooner than body text to stay clear of the timeline columns.
  static const double maxTextScale = 1.5;

  /// Height of the year label at the current (capped) text scale; it sits directly above the dashed line.
  static double labelHeight(BuildContext context) =>
      MediaQuery.textScalerOf(context).clamp(maxScaleFactor: maxTextScale).scale($styles.text.h2.fontSize!) *
      ($styles.text.h2.height ?? 1.2);

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
      // Keep the label within half the screen width, so it doesn't swamp the popup and timeline.
      label = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 2),
        child: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerRight, child: label),
      );
    }
    label = MediaQuery.withClampedTextScaling(maxScaleFactor: maxTextScale, child: label);
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
