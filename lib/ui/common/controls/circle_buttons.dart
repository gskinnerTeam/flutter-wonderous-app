import 'package:wonders/common_libs.dart';

class CircleBtn extends StatelessWidget {
  const CircleBtn({
    Key? key,
    required this.child,
    required this.onPressed,
    this.border,
    this.bgColor,
    required this.semanticLabel,
  }) : super(key: key);
  final VoidCallback onPressed;
  final Color? bgColor;
  final BorderSide? border;
  final Widget child;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return AppBtn(
      onPressed: onPressed,
      semanticLabel: semanticLabel,
      minimumSize: Size(48, 48),
      padding: EdgeInsets.zero,
      children: [child],
      circular: true,
      bgColor: bgColor,
      border: border,
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
    required this.semanticLabel,
  }) : super(key: key);
  final IconData icon;
  final VoidCallback onPressed;
  final BorderSide? border;
  final Color? bgColor;
  final Color? color;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    Color defaultColor = context.colors.greyStrong;
    Color iconColor = color ?? context.colors.offWhite;
    return CircleBtn(
      child: Icon(icon, size: context.insets.md, color: iconColor),
      onPressed: onPressed,
      border: border,
      bgColor: bgColor ?? defaultColor,
      semanticLabel: semanticLabel,
    );
  }
}

class BackBtn extends StatelessWidget {
  const BackBtn({
    Key? key,
    this.useCloseIcon = false,
    this.onPressed,
  }) : super(key: key);

  final bool useCloseIcon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleIconBtn(
      icon: useCloseIcon ? Icons.close : Icons.arrow_back,
      onPressed: onPressed ?? () => Navigator.pop(context),
      semanticLabel: useCloseIcon ? 'close' : 'back',
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
        child: BackBtn(
          useCloseIcon: useCloseIcon,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
