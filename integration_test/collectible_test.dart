import 'package:patrol/patrol.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/patrol_keys.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  patrolTest(
    'discover pendant collectible in chichen itza',
    nativeAutomation: true,
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.benchmarkLive,
    ($) async {
      await runWonderous($: $);

      await onboarding($: $);

      await openChichenItza($: $);
      await $(K.collectible(WonderType.chichenItza, 0))
          .scrollTo(
            scrollable: $(PageStorageKey('editorial')).$(Scrollable),
            andSettle: false,
          )
          .tap(andSettle: false); // trzeba było dodać scrollable, bo inaczej hot restart nie działał w tym miejscu
      await pumpAndMaybeSettle($: $);
      await $('VIEW IN MY COLLECTION').tap();
      await $(K.collectibleDetails(WonderType.chichenItza, 'Pendant')).tap();
      await $('Pendant').waitUntilVisible();
    },
  );
}
