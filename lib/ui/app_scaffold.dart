import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/app_scroll_behavior.dart';

class WondersAppScaffold extends StatelessWidget with GetItMixin {
  WondersAppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    bool showUrl = true;
    final size = MediaQuery.of(context).size;
    final theme = ColorTheme(watchX((SettingsController s) => s.themeType));
    // Construct an AppStyle using app size and current themeType.
    final styles = AppStyle(screenSize: size, colors: theme);
    // Pass the style down to the tree with provider and inject a themData to style existing Material components.
    return Theme(
      data: theme.toThemeData(),
      child: Provider<AppStyle>.value(
        value: styles,
        builder: (context, child) => child!,
        // Provide a custom scroll config for easier responsive testing on desktop
        child: ScrollConfiguration(
          behavior: AppScrollBehavior(),
          // Provide a default texts style to allow Hero's to render text properly
          child: DefaultTextStyle(
            style: styles.text.body,
            child: Column(
              children: [
                if (showUrl) Text(appRouter.location),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
