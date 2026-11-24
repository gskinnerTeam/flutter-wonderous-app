import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/ui/common/themed_text.dart';

class TimelineEventCard extends StatelessWidget {
  const TimelineEventCard({
    super.key,
    required this.year,
    required this.text,
    this.darkMode = false,
  });
  final int year;
  final String text;
  final bool darkMode;

  /// Above this text scale, the year column is too narrow for the text beside it, so the card stacks vertically.
  static const double _stackedTextScale = 2;

  @override
  Widget build(BuildContext context) {
    final bool stacked = MediaQuery.textScalerOf(context).scale(1) >= _stackedTextScale;
    final Color dividerColor = darkMode ? Colors.white : $styles.colors.black;
    // Years are a single line of display text, so they shrink to fit their column rather than wrapping digits.
    final Widget date = FittedBox(
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
    final Widget content = Focus(child: Text(text, style: $styles.text.body));

    return MergeSemantics(
      child: Padding(
        padding: EdgeInsets.only(bottom: $styles.insets.sm),
        child: DefaultTextColor(
          color: darkMode ? Colors.white : Colors.black,
          child: Container(
            color: darkMode ? $styles.colors.greyStrong : $styles.colors.offWhite,
            padding: EdgeInsets.all($styles.insets.sm),
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
