import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/utils/persistent_controller.dart';

class SettingsController extends PersistentController {
  @override
  String get fileName => 'settings.dat';

  late final themeType = ValueNotifier<ColorThemeType>(ColorThemeType.orange)..addListener(scheduleSave);
  late final enableMotionBlur = ValueNotifier<bool>(false)..addListener(scheduleSave);
  late final swipeThreshold = ValueNotifier<double>(.25)..addListener(scheduleSave);
  late final enableFpsMeter = ValueNotifier<bool>(true)..addListener(scheduleSave);

  @override
  void copyFromJson(Map<String, dynamic> value) {
    themeType.value = ColorThemeType.values[value['themeType'] ?? themeType.value.index];
    enableMotionBlur.value = value['enableMotionBlur'] ?? enableMotionBlur.value;
    swipeThreshold.value = value['swipeThreshold'] ?? swipeThreshold.value;
    enableFpsMeter.value = value['enableFpsMeter'] ?? enableFpsMeter.value;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'themeType': themeType.value.index,
      'enableMotionBlur': enableMotionBlur.value,
      'swipeThreshold': swipeThreshold.value,
      'enableFpsMeter': enableFpsMeter.value,
    };
  }
}
