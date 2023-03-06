import 'package:patrol/patrol.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/patrol_keys.dart';

void main() {
  patrolTest(
    'first experimental test',
    nativeAutomation: true,
    ($) async {
      prepareApp();
      await $.pumpWidget(WondersApp());
      await initializeApp();
      await $('Swipe left to continue').waitUntilVisible();

      // await _swipeLeft($);
      // await _swipeLeft($);

      await $(K.finishIntroButton)
          .which<AnimatedOpacity>((button) => button.opacity == 1)
          .$(CircleIconBtn)
          .scrollTo()
          .tap();
      await $(K.hamburgerMenuButton).waitUntilVisible();

      await $(ValueKey(WonderType.chichenItza)).scrollTo().tap();
      await $(K.collectible(WonderType.chichenItza, 0)).scrollTo().tap();
      await $(K.hamburgerMenuButton).tap(); // to jest ten sam widget, tylko z inna ikona w roznych wywolaniach
      await $.pump(Duration(seconds: 5));
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
