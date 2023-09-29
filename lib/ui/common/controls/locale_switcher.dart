import 'package:wonders/common_libs.dart';

class LocaleSwitcher extends StatelessWidget with GetItMixin {
  LocaleSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = watchX((SettingsLogic s) => s.currentLocale);
    Future<void> handleSwapLocale() async {
      final newLocale = Locale(locale == 'en' ? 'zh' : 'en');
      await settingsLogic.changeLocale(newLocale);
    }

    return AppBtn.from(text: $strings.localeSwapButton, onPressed: handleSwapLocale);
  }
}
