import 'package:statsfl/statsfl.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/app_scroll_behavior.dart';

class WondersAppScaffold extends StatelessWidget with GetItMixin {
  WondersAppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Construct an AppStyle using app size and current themeType.
    final styles = AppStyle(screenSize: size);
    bool enableFpsMeter = watchX((SettingsController c) => c.enableFpsMeter);
    // Pass our custom style down to the tree with provider and inject a themData to style existing Material components.
    return StatsFl(
      height: 30,
      isEnabled: enableFpsMeter,
      align: Alignment.topCenter,
      child: Provider<AppStyle>.value(
        value: styles,
        child: Theme(
          data: styles.colors.toThemeData(),
          //Custom scroll behavior to make responsive testing easier on desktop
          child: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            // Provide a default texts style to allow Hero's to render text properly
            child: DefaultTextStyle(
              style: styles.text.body,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
