import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/app_scroll_behavior.dart';

class WondersAppScaffold extends StatelessWidget with GetItMixin {
  WondersAppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

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
    Animate.defaultDuration = $styles.times.fast;
    return Stack(
      children: [
        Theme(
          data: $styles.colors.toThemeData(),
          // Provide a default texts style to allow Hero's to render text properly
          child: DefaultTextStyle(
            style: $styles.text.body,
            // Use a custom scroll behavior across entire app
            child: ScrollConfiguration(
              behavior: AppScrollBehavior(),
              child: child,
            ),
          ),
        ),
        
        //TODO: just some test UI to check swapping behavior, need to get finalized design and location 
        Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: TextButton(
              onPressed: _handleSwapLocale,
              child: Container(
                decoration: BoxDecoration(
                  color: $styles.colors.greyStrong.withOpacity(.7),
                  borderRadius: BorderRadius.all(Radius.circular($styles.corners.md)),
                ),
                padding: EdgeInsets.all($styles.insets.sm),
                child: Text($strings.localeSwapButton, style: $styles.text.btn.copyWith(color: $styles.colors.white)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
