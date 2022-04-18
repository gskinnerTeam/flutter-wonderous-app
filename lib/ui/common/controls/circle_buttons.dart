import 'package:wonders/common_libs.dart';

class CircleBtn extends StatelessWidget {
  const CircleBtn({
    Key? key,
    required this.child,
    required this.onPressed,
    this.border,
    this.bgColor,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Color? bgColor;
  final BorderSide? border;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: ClipRRect(borderRadius: BorderRadius.circular(99), child: child),
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: bgColor,
          shape: CircleBorder(side: border ?? BorderSide.none),
          minimumSize: Size(48, 48),
          primary: bgColor),
    );
  }
}

class CircleIconBtn extends StatelessWidget {
  const CircleIconBtn({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.border,
    this.bgColor,
    this.color,
  }) : super(key: key);
  final IconData icon;
  final VoidCallback onPressed;
  final BorderSide? border;
  final Color? bgColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Color defaultColor = context.colors.greyStrong;
    Color iconColor = color ?? context.colors.offWhite;
    return CircleBtn(
      child: Icon(icon, size: 24, color: iconColor),
      onPressed: onPressed,
      border: border,
      bgColor: bgColor ?? defaultColor,
    );
  }
}

// A circular back button for adding to a Stack, to ensure consistent sizing and location.
class PositionedBackBtn extends StatelessWidget {
  const PositionedBackBtn({
    Key? key,
    this.useCloseIcon = false,
    this.onPressed,
  }) : super(key: key);

  final bool useCloseIcon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(context.insets.sm),
        child: CircleIconBtn(
          icon: useCloseIcon ? Icons.close : Icons.arrow_back,
          onPressed: onPressed ?? () => Navigator.pop(context),
        ),
      ),
    );
  }
}
