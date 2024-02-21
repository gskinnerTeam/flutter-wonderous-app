import 'package:wonders/common_libs.dart';

class DefaultTextColor extends StatelessWidget {
  const DefaultTextColor({super.key, required this.color, required this.child});
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(context).style.copyWith(color: color),
      child: child,
    );
  }
}

class LightText extends StatelessWidget {
  const LightText({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextColor(
        color: Colors.white,
        child: child,
      );
}

class DarkText extends StatelessWidget {
  const DarkText({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextColor(
        color: $styles.colors.black,
        child: child,
      );
}
