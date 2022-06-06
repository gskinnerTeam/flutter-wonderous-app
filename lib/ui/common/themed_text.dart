import 'package:wonders/common_libs.dart';

class DefaultTextColor extends StatelessWidget {
  const DefaultTextColor({Key? key, required this.color, required this.child}) : super(key: key);
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
  const LightText({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextColor(
        color: Colors.white,
        child: child,
      );
}

class DarkText extends StatelessWidget {
  const DarkText({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextColor(
        color: $styles.colors.black,
        child: child,
      );
}
