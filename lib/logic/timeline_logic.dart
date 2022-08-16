import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/timeline_data.dart';

class TimelineLogic {
  final List<TimelineEvent> events = [];

  Future<void> init() async {
    events.addAll(GlobalEventsData().globalEvents);

    for (var w in wondersLogic.all) {
      events.add(
        TimelineEvent(
          w.startYr,
          StringUtils.supplant($strings.timelineLabelConstruction, {'{title}': w.title}),
        ),
      );
    }
  }
}
