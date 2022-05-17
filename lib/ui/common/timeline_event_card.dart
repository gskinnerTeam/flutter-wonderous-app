import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';

class TimelineEventCard extends StatelessWidget {
  const TimelineEventCard({Key? key, required this.year, required this.text}) : super(key: key);
  final int year;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.insets.sm),
      child: Container(
        color: context.colors.offWhite,
        padding: EdgeInsets.all(context.insets.sm),
        child: Row(
          children: [
            SizedBox(
              width: 75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${year.abs()}', style: context.text.h3.copyWith(fontWeight: FontWeight.w400, height: 1)),
                  Text(StringUtils.getYrSuffix(year), style: context.text.bodySmall),
                ],
              ),
            ),
            Center(child: Container(width: 1, height: 50, color: context.colors.black)),
            Gap(context.insets.sm),
            Expanded(
              child: Text(text, style: context.text.bodySmall),
            ),
          ],
        ),
      ),
    );
  }
}
