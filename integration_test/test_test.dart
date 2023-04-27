import 'package:patrol/patrol.dart';
import 'package:wonders/common_libs.dart';

void main() {
  patrolTest(
    'first experimental test',
    nativeAutomation: true,
    // bindingType: BindingType.integrationTest,
    ($) async {
      prepareApp();
      await $.pumpWidget(WondersApp());
      await initializeApp();
      await $('Swipe left to continue').waitUntilVisible();

      await _swipeLeft($);
      await _swipeLeft($);
      await $(#finishIntroButton).tap();
      await $(#hamburgerMenuButton).tap();
      await $('About this app').tap();
    },
  );
}

Future<void> _swipeLeft(PatrolTester $) async {
  await $.pumpAndSettle(duration: Duration(seconds: 2));
  await $.native.swipe(
    from: Offset(0.9, 0.5),
    to: Offset(0.2, 0.5),
    steps: 1,
  );
}
