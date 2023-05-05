import 'package:patrol/patrol.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/patrol_keys.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // tearDown(() {

  // });
  patrolTest(
    'first experimental test',
    nativeAutomation: true,
    ($) async {
      await (await SharedPreferences.getInstance()).clear();
      prepareApp();
      await $.pumpWidget(WondersApp());
      await initializeApp();
      collectiblesLogic.reset();

      await $('Swipe left to continue').waitUntilVisible();
      await $(K.finishIntroButton)
          .which<AnimatedOpacity>((button) => button.opacity == 1)
          .$(CircleIconBtn)
          .scrollTo()
          .tap();
      await $(K.hamburgerMenuButton).waitUntilVisible();

      await $(K.wonderScreen(WonderType.chichenItza)).scrollTo().tap(andSettle: false);
      await $(K.collectible(WonderType.chichenItza, 0))
          .scrollTo(
            scrollable: $(PageStorageKey('editorial')).$(Scrollable),
            andSettle: false,
          )
          .tap(andSettle: false); // trzeba było dodać scrollable, bo inaczej hot restart nie działał w tym miejscu
      await $('VIEW IN MY COLLECTION').tap();
      await $(K.collectibleDetails(WonderType.chichenItza, 'Pendant')).tap();
      await $('Pendant').waitUntilVisible();

      addTearDown(() async {
        await $('Pendant').waitUntilVisible();
      });
    },
  );
}

// Future<void> _swipeLeft(PatrolTester $) async {
//   await $.native.swipe(
//     from: Offset(0.9, 0.5),
//     to: Offset(0.2, 0.5),
//     steps: 1,
//   );
//   await $.tester.dragFrom(Offset(250, 100), Offset(50, 100));
//   await $.pumpAndSettle();
// }
