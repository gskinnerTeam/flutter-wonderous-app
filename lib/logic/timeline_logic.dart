import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/timeline_data.dart';

class TimelineLogic {
  final events = globalEvents;

  TimelineLogic() {
    for (var w in wondersLogic.all) {
      events.add(
        TimelineEvent(w.startYr, 'Construction of ${w.title} begins.'),
      );
    }
  }
}
