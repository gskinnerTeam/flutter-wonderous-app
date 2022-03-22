import 'package:wonders/common_libs.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.splashColor,
    this.bgColor,
    this.padding,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? splashColor;
  final Widget child;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(padding ?? context.insets.lg),
          primary: bgColor,
          onPrimary: splashColor),
    );
  }
}
