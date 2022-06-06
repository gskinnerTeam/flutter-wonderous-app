import 'package:wonders/common_libs.dart';

class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({Key? key, required this.child, this.bgColor, this.isDark = false, this.enableSafeArea = true})
      : super(key: key);
  final Widget child;

  /// Optional bgColor override
  final Color? bgColor;

  /// Controls background and text color (defers to bgColor if set)
  final bool isDark;

  /// If this is set to false, the child is responsible for handling its own safe areas.
  final bool enableSafeArea;

  @override
  Widget build(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.red,
          textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
        ),
        child: Container(
          color: bgColor ?? (isDark ? $styles.colors.greyStrong : $styles.colors.offWhite),
          child: enableSafeArea ? SafeArea(child: child) : child,
        ),
      );
}
