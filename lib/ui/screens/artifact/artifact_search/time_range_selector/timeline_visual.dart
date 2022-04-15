import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/cards/glass_card.dart';
import 'dart:math' as math;

// Expandable timerange selector component that further refines Artifact Search based on date range.
class TimelineVisual extends StatelessWidget {
  const TimelineVisual({Key? key, required this.wonderDataList}) : super(key: key);

  final List<WonderData> wonderDataList;

  @override
  Widget build(BuildContext context) {
    int earliestYr = wonderDataList[0].startYr;
    int latestYr = wonderDataList[0].endYr;

    for (WonderData data in wonderDataList) {
      if (data.startYr < earliestYr) {
        earliestYr = data.startYr;
      }
      if (data.endYr < latestYr) {
        latestYr = data.endYr;
      }
    }

    return LayoutBuilder(builder: (_, constraints) {
      return Container();
    });
  }
}
