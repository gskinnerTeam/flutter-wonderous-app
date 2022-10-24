import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/app_scroll_behavior.dart';

class WondersAppScaffold extends StatelessWidget with GetItMixin {
  WondersAppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Animate.defaultDuration = $styles.times.fast;
    // Listen to the device size, and update AppStyle when it changes
    //$styles = AppStyle(appSize: null); //Size(context.widthPx, context.heightPx));
    $styles = AppStyle(appSize: Size(context.widthPx, context.heightPx));
    return Stack(
      key: ValueKey($styles.scale),
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
      ],
    );
  }
}
