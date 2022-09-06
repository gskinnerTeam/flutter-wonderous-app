import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wonders/common_libs.dart';

class LocaleButton extends StatelessWidget {
  const LocaleButton({Key? key}) : super(key: key);

  Future<void> _handleSwapLocale() async {
    final currentLocale = settingsLogic.currentLocale.value;
    final newLocale = Locale(currentLocale == 'en' ? 'zh' : 'en');
    settingsLogic.currentLocale.value = newLocale.languageCode;
    await localeLogic.refreshIfChanged(newLocale);
    wondersLogic.init();
    timelineLogic.init();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _handleSwapLocale,
      child: Container(
        decoration: BoxDecoration(
          color: $styles.colors.greyStrong.withOpacity(.7),
          borderRadius: BorderRadius.all(Radius.circular($styles.corners.md)),
        ),
        padding: EdgeInsets.all($styles.insets.sm),
        child: Text($strings.localeSwapButton, style: $styles.text.btn.copyWith(color: $styles.colors.white)),
      ),
    );
  }
}
