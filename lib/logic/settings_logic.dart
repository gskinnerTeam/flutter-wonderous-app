import 'package:flutter/foundation.dart';
import 'package:wonders/logic/common/save_load_mixin.dart';

class SettingsLogic with ThrottledSaveLoadMixin {
  @override
  String get fileName => 'settings.dat';

  late final hasCompletedOnboarding = ValueNotifier<bool>(false)..addListener(scheduleSave);
  late final hasDismissedSearchMessage = ValueNotifier<bool>(false)..addListener(scheduleSave);
  late final currentLocale = ValueNotifier<String>('en')..addListener(scheduleSave);

  final bool useBlurs = defaultTargetPlatform != TargetPlatform.android;

  @override
  void copyFromJson(Map<String, dynamic> value) {
    hasCompletedOnboarding.value = value['hasCompletedOnboarding'] ?? false;
    hasDismissedSearchMessage.value = value['hasDismissedSearchMessage'] ?? false;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'hasCompletedOnboarding': hasCompletedOnboarding.value,
      'hasDismissedSearchMessage': hasDismissedSearchMessage.value,
    };
  }
}
