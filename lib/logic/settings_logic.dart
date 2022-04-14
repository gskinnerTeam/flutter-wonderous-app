import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/prefs_file_mixin.dart';

class SettingsLogic with SaveLoadMixin {
  @override
  String get fileName => 'settings.dat';

  late final enableMotionBlur = ValueNotifier<bool>(false)..addListener(scheduleSave);
  late final swipeThreshold = ValueNotifier<double>(.25)..addListener(scheduleSave);
  late final enableFpsMeter = ValueNotifier<bool>(true)..addListener(scheduleSave);
  late final enableClouds = ValueNotifier<bool>(true)..addListener(scheduleSave);

  @override
  void copyFromJson(Map<String, dynamic> value) {
    return;
    //SB: Disabled loading of settings to allow us to more easily reset defaults values for QA testers.
    enableMotionBlur.value = value['enableMotionBlur'] ?? enableMotionBlur.value;
    swipeThreshold.value = value['swipeThreshold'] ?? swipeThreshold.value;
    enableFpsMeter.value = value['enableFpsMeter'] ?? enableFpsMeter.value;
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
