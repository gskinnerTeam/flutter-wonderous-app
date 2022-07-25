import 'package:wonders/_tools/localization_helper.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/timeline_data.dart';

class TimelineLogic {
  final events = globalEvents;

  TimelineLogic() {
    for (var w in wondersLogic.all) {
      events.add(
        TimelineEvent(w.startYr, LocalizationHelper.instance.timelineLabelConstruction.supplant({'{title}': w.title})),
      );
    }
  }
}
