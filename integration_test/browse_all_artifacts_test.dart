import 'dart:ui';

import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
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
      await $.pump(Duration(seconds: 1));
      await $.tester.drag($(K.timelineRightArrow(false)), Offset(-100, 0), kind: PointerDeviceKind.mouse);
      await $.pump(Duration(seconds: 1));
      await $.tester.drag($(K.timelineRangeSelector), Offset(-50, 0), kind: PointerDeviceKind.mouse);
      await $.pump(Duration(seconds: 1));
      await $.tester.drag($(K.timelineRightArrow(true)), Offset(30, 0), kind: PointerDeviceKind.mouse);
      await $.pump(Duration(seconds: 1));
      await $(K.resultTile(15)).scrollTo(scrollable: $(K.resultsGrid).$(Scrollable)).tap();
      await $.tester.flingFrom(Offset(200, 500), Offset(0, -200), 1000);
      await $.pump(Duration(seconds: 2));
    },
  );
}
