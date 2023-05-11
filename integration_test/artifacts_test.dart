import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/patrol_keys.dart';

import 'helpers.dart';

void main() {
  patrolTest(
    'artifacts carousel',
    nativeAutomation: true,
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.benchmarkLive,
    ($) async {
      await runWonderous($: $);

      await onboarding($: $);

      await openChichenItza($: $);
      await $(K.artifactsSectionButton).tap(andSettle: false);
      await pumpAndMaybeSettle($: $);
      await swipeUntilVisible(
        $: $,
        finder: $(K.artifact('Head of a Rain God')),
        view: $(PageView).$(Scrollable),
      );
      await $(K.artifact('Head of a Rain God')).tap();
    },
  );
}
