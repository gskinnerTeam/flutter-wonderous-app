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
          padding: EdgeInsets.zero,
          shape: CircleBorder(),
          minimumSize: Size(60, 60),
          primary: bgColor,
          onPrimary: splashColor),
    );
  }
}
