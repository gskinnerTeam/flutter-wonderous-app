import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/save_load_mixin.dart';

class SettingsLogic with ThrottledSaveLoadMixin {
  @override
  String get fileName => 'settings.dat';

  late final enableMotionBlur = ValueNotifier<bool>(false)..addListener(scheduleSave);
  late final swipeThreshold = ValueNotifier<double>(.25)..addListener(scheduleSave);
  late final enableFpsMeter = ValueNotifier<bool>(false)..addListener(scheduleSave);
  late final enableClouds = ValueNotifier<bool>(true)..addListener(scheduleSave);

  @override
  void copyFromJson(Map<String, dynamic> value) {
    return;
    //SB: Disabled loading of settings to allow us to more easily reset default values for QA testers, we should re-enable this at some pt. If we even have any actual settings.
    // enableMotionBlur.value = value['enableMotionBlur'] ?? enableMotionBlur.value;
    // swipeThreshold.value = value['swipeThreshold'] ?? swipeThreshold.value;
    // enableFpsMeter.value = value['enableFpsMeter'] ?? enableFpsMeter.value;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'enableMotionBlur': enableMotionBlur.value,
      'swipeThreshold': swipeThreshold.value,
      'enableFpsMeter': enableFpsMeter.value,
    };
  }
}
