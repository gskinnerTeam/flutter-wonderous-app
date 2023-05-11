import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:wonders/patrol_keys.dart';
import 'package:wonders/ui/common/controls/eight_way_swipe_detector.dart';

import 'helpers.dart';

void main() {
  patrolTest(
    'first experimental test',
    nativeAutomation: true,
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.benchmarkLive,
    ($) async {
      await runWonderous($: $);

      await onboarding($: $);

      await openChichenItza($: $);
      await $(K.photosSectionButton).tap(andSettle: false);
      await pumpAndMaybeSettle($: $);
      await swipeUntilVisible(
        $: $,
        finder: $(EightWaySwipeDetector).which<EightWaySwipeDetector>(
          (widget) => widget.key == K.image('14'),
        ),
        view: $(EightWaySwipeDetector),
        step: Offset(-200, 0),
      );
    },
  );
}
