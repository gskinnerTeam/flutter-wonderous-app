import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:wonders/patrol_keys.dart';

import 'helpers.dart';

void main() {
  patrolTest(
    'artifactshj carousel',
    nativeAutomation: true,
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.benchmarkLive,
    ($) async {
      await runWonderous($: $);

      await onboarding($: $);

      await openChichenItza($: $);
      await $(K.artifactsSectionButton).tap(andSettle: false);
      await pumpAndMaybeSettle($: $);
      await $(BottomCenter).$(K.browseAllArtifactsButton).tap();
      await $(K.timeRangeSelectorFloatingButton).tap();
      await swipeUntilVisible(
        $: $,
        finder: $('1850'),
        view: $(K.dragArrow),
        step: Offset(50, 0),
        duration: Duration(seconds: 1),
      );
      await swipeUntilVisible(
        $: $,
        finder: $('1950'),
        view: $(K.dragArrow),
        step: Offset(10, 0),
        duration: Duration(seconds: 1),
      );
      await swipeUntilVisible(
        $: $,
        finder: $('1980'),
        view: $(K.dragArrow),
        step: Offset(10, 0),
        duration: Duration(seconds: 1),
      );
      await $.pump(Duration(seconds: 10));
    },
  );
}
