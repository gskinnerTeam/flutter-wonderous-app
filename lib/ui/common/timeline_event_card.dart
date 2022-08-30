import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';

class TimelineEventCard extends StatelessWidget {
  const TimelineEventCard({Key? key, required this.year, required this.text}) : super(key: key);
  final int year;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Padding(
        padding: EdgeInsets.only(bottom: $styles.insets.sm),
        child: Container(
          color: $styles.colors.offWhite,
          padding: EdgeInsets.all($styles.insets.sm),
          child: Row(
            children: [
              SizedBox(
                width: 75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${year.abs()}', style: $styles.text.h3.copyWith(fontWeight: FontWeight.w400, height: 1)),
                    Text(StringUtils.getYrSuffix(year), style: $styles.text.bodySmall),
                  ],
                ),
              ),
              Center(child: Container(width: 1, height: 50, color: $styles.colors.black)),
              Gap($styles.insets.sm),
              Expanded(
                child: Text(text, style: $styles.text.bodySmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
