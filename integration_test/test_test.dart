import 'package:patrol/patrol.dart';
import 'package:wonders/common_libs.dart';

void main() {
  patrolTest(
    'first experimental test',
    nativeAutomation: true,
    //bindingType: BindingType.integrationTest,
    ($) async {
      prepareApp();
      await $.pumpWidget(WondersApp());
      await initializeApp();
      await $('Swipe left to continue').waitUntilVisible();
    },
  );
}
