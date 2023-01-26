import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/timeline_data.dart';

class TimelineLogic {
  List<TimelineEvent> events = [];

  void init() {
    // Create an event for each wonder, and merge it with the list of GlobalEvents
    events = [
      ...GlobalEventsData().globalEvents,
      ...wondersLogic.all.map(
        (w) => TimelineEvent(
          w.startYr,
          $strings.timelineLabelConstruction(w.title),
        ),
      )
    ];
  }
}
