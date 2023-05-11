import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/patrol_keys.dart';

Future<void> swipeUntilVisible({
  required PatrolTester $,
  required Finder finder,
  required Finder view,
  int maxIteration = 100,
  Offset step = const Offset(-200, 0),
  Duration duration = const Duration(milliseconds: 100),
}) async {
  var viewPatrolFinder = $(view);
  viewPatrolFinder = (await viewPatrolFinder.waitUntilVisible()).first;
  var iterationsLeft = maxIteration;
  while (iterationsLeft > 0 && finder.hitTestable().evaluate().isEmpty) {
    await $.tester.drag(viewPatrolFinder, step);
    await pumpAndMaybeSettle($: $);
    iterationsLeft -= 1;
  }
}

Future<void> pumpAndMaybeSettle({
  required PatrolTester $,
  Duration duration = const Duration(milliseconds: 100),
  Duration timeout = const Duration(seconds: 10),
}) async {
  int iteration = 100;
  print('started pumpAndMaybeSettle');
  while ($.tester.hasRunningAnimations && iteration > 0) {
    await $.pump(Duration(milliseconds: 50));
    iteration--;
  }
  if (iteration <= 0) {
    print('pumpAndMaybeSettle timed out');
  }
}

Future<void> runWonderous({
  required PatrolTester $,
}) async {
  await (await SharedPreferences.getInstance()).clear();
  prepareApp();
  await $.pumpWidgetAndSettle(WondersApp());
  await initializeApp();
}

Future<void> onboarding({
  required PatrolTester $,
}) async {
  await $('Swipe left to continue').waitUntilVisible();
  await swipeUntilVisible(
    $: $,
    finder: $(K.finishIntroButton)
        .which<AnimatedOpacity>(
          (button) => button.opacity == 1,
        )
        .$(CircleIconBtn),
    view: $(Scrollable),
    step: Offset(-300, 0),
  );
  await $(K.finishIntroButton)
      .which<AnimatedOpacity>(
        (button) => button.opacity == 1,
      )
      .$(CircleIconBtn)
      .tap();
  await $(K.hamburgerMenuButton).waitUntilVisible();
}

Future<void> openChichenItza({
  required PatrolTester $,
}) async {
  await swipeUntilVisible(
    $: $,
    finder: $(K.wonderScreen(WonderType.chichenItza)),
    view: $(Scrollable),
    step: Offset(-300, 0),
  );
  await $(K.wonderScreen(WonderType.chichenItza)).tap(andSettle: false);
  await pumpAndMaybeSettle($: $);
}
