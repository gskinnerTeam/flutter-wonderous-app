import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/ui/common/themed_text.dart';

class TimelineEventCard extends StatelessWidget {
  const TimelineEventCard({
    super.key,
    required this.year,
    required this.text,
    this.darkMode = false,
    this.compactYear = false,
  });
  final int year;
  final String text;
  final bool darkMode;

  /// When stacked, show the year as a single compact line ("700 BCE") with capped text scale. Used by the Timeline popup,
  /// where vertical space is limited.
  final bool compactYear;

  /// Max text scale for the compact year header.
  static const double compactYearMaxTextScale = 1.5;

  /// Above this text scale, the year column is too narrow for the text beside it, so the card stacks vertically.
  static const double stackedTextScale = 2;

  @override
  Widget build(BuildContext context) {
    final bool stacked = MediaQuery.textScalerOf(context).scale(1) >= stackedTextScale;
    final Color dividerColor = darkMode ? Colors.white : $styles.colors.black;
    // Years are a single line of display text, so they shrink to fit their column rather than wrapping digits.
    final Widget fullDate = FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${year.abs()}',
            style: $styles.text.h3.copyWith(fontWeight: FontWeight.w400, height: 1),
          ),
          Text(StringUtils.getYrSuffix(year), style: $styles.text.bodySmall),
        ],
      ),
    );
    final bool compact = stacked && compactYear;
    final Widget date = compact
        ? MediaQuery.withClampedTextScaling(
            maxScaleFactor: compactYearMaxTextScale,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                StringUtils.formatYr(year),
                maxLines: 1,
                softWrap: false,
                style: $styles.text.h3.copyWith(fontWeight: FontWeight.w400, height: 1),
              ),
            ),
          )
        : fullDate;
    final Widget content = Focus(child: Text(text, style: $styles.text.body));

    return MergeSemantics(
      child: Padding(
        padding: EdgeInsets.only(bottom: compact ? 0 : $styles.insets.sm),
        child: DefaultTextColor(
          color: darkMode ? Colors.white : Colors.black,
          child: Container(
            color: darkMode ? $styles.colors.greyStrong : $styles.colors.offWhite,
            padding: compact
                ? EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.xs)
                : EdgeInsets.all($styles.insets.sm),
            child: stacked
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      date,
                      Gap($styles.insets.xs),
                      Container(height: 1, color: dividerColor),
                      Gap($styles.insets.xs),
                      content,
                    ],
                  )
                : IntrinsicHeight(
                    child: Row(
                      children: [
                        /// Date
                        SizedBox(
                          width: 75,
                          child: Align(alignment: Alignment.topLeft, child: date),
                        ),

                        /// Divider
                        Container(width: 1, color: dividerColor),

                        Gap($styles.insets.sm),

                        /// Text content
                        Expanded(child: content),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
