import 'package:wonders/common_libs.dart';

class LocaleSwitcher extends StatelessWidget with GetItMixin {
  LocaleSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = watchX((SettingsLogic s) => s.currentLocale);
    Future<void> handleSwapLocale() async {
      final newLocale = Locale(locale == 'en' ? 'zh' : 'en');
      await settingsLogic.setLocale(newLocale);
    }

    return AppBtn.from(
        padding: EdgeInsets.symmetric(vertical: $styles.insets.sm, horizontal: $styles.insets.sm),
        text: $strings.localeSwapButton,
        onPressed: handleSwapLocale);
  }
}
