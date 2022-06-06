import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/app_scroll_behavior.dart';

class WondersAppScaffold extends StatelessWidget with GetItMixin {
  WondersAppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Animate.defaultDuration = $styles.times.fast;
    // Pass our custom style down to the tree with provider and inject a themData to style existing Material components.
    return Stack(
      children: [
        Theme(
          data: $styles.colors.toThemeData(),
          // Provide a default texts style to allow Hero's to render text properly
          child: DefaultTextStyle(
            style: $styles.text.body,
            //Custom scroll behavior to make responsive testing easier on desktop
            child: ScrollConfiguration(
              behavior: AppScrollBehavior(),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
