import 'package:flutter/scheduler.dart';
import 'package:statsfl/statsfl.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/app_scroll_behavior.dart';

class WondersAppScaffold extends StatelessWidget with GetItMixin {
  WondersAppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    // Construct an AppStyle using the current screen size.
    final styles = AppStyle(screenSize: context.sizePx);
    FXAnimate.defaultDuration = styles.times.fast;
    // Respect fps meter setting
    bool enableFpsMeter = watchX((SettingsLogic c) => c.enableFpsMeter);
    // Pass our custom style down to the tree with provider and inject a themData to style existing Material components.
    return Stack(
      children: [
        Provider<AppStyle>.value(
          value: styles,
          child: Theme(
            data: styles.colors.toThemeData(),
            //Custom scroll behavior to make responsive testing easier on desktop
            child: DefaultTextStyle(
              style: styles.text.body1,
              child: ScrollConfiguration(
                behavior: AppScrollBehavior(),
                // Provide a default texts style to allow Hero's to render text properly
                child: child,
              ),
            ),
          ),
        ),

        ///
        SafeArea(
          child: StatsFl(height: 30, isEnabled: enableFpsMeter, align: Alignment.topCenter, child: SizedBox.expand()),
        ),
      ],
    );
  }
}
