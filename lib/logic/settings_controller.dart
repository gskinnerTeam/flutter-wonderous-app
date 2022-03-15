import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/utils/persistent_controller.dart';

class SettingsController extends PersistentController {
  @override
  String get fileName => 'settings.dat';

  late final themeType = ValueNotifier<ColorThemeType>(ColorThemeType.orange)..addListener(scheduleSave);

  @override
  void copyFromJson(Map<String, dynamic> value) {
    themeType.value = ColorThemeType.values[value['themeType'] ?? themeType.value.index];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'themeType': themeType.value.index,
    };
  }
}
