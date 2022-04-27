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
      child: Padding(
        padding: EdgeInsets.all(context.insets.sm),
        child: Icon(icon, size: context.insets.md, color: iconColor),
      ),
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
    this.icon = Icons.arrow_back,
    this.onPressed,
    this.semanticLabel = 'back',
  }) : super(key: key);

  const BackBtn.close({Key? key, VoidCallback? onPressed})
      : this(key: key, icon: Icons.close, onPressed: onPressed, semanticLabel: 'close');

  final IconData icon;
  final VoidCallback? onPressed;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return CircleIconBtn(
      icon: icon,
      onPressed: onPressed ?? () => Navigator.pop(context),
      semanticLabel: 'back',
    );
  }

  Widget padded() {
    return _BackPositioned(child: this);
  }
}

class _BackPositioned extends StatelessWidget {
  const _BackPositioned({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(context.insets.sm),
        child: child,
      ),
    );
  }
}
