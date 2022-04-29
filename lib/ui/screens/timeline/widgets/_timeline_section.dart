part of '../timeline_screen.dart';

class TimelineSection extends StatelessWidget {
  const TimelineSection(this.data, this.selectedYr, {Key? key}) : super(key: key);
  final WonderData data;
  final int selectedYr;

  @override
  Widget build(BuildContext context) {
    // get a fraction from 0 - 1 based on selected yr and start/end yr of the wonder
    // 500, 250, 750
    int startYr = data.startYr, endYr = data.endYr;
    double fraction = (selectedYr - startYr) / (endYr - startYr);
    fraction = fraction.clamp(0, 1);
    return Container(
      alignment: Alignment(0, -1 + fraction * 2),
      padding: EdgeInsets.all(context.insets.sm),
      decoration: BoxDecoration(color: data.type.fgColor),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: data.type.bgColor,
          borderRadius: BorderRadius.circular(99),
        ),
      ),
    );
  }
}
