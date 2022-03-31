import 'package:wonders/common_libs.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.border,
    this.bgColor,
    this.padding,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Color? bgColor;
  final BorderSide? border;
  final Widget child;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: ClipRRect(borderRadius: BorderRadius.circular(99), child: child),
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: bgColor,
          shape: CircleBorder(side: border ?? BorderSide.none),
          minimumSize: Size(60, 60),
          primary: bgColor),
    );
  }
}
