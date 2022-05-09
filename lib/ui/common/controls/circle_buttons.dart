import 'package:wonders/common_libs.dart';

class CircleBtn extends StatelessWidget {
  const CircleBtn({
    Key? key,
    required this.child,
    required this.onPressed,
    this.border,
    this.bgColor,
    this.size,
    required this.semanticLabel,
  }) : super(key: key);
  final VoidCallback onPressed;
  final Color? bgColor;
  final BorderSide? border;
  final Widget child;
  final double? size;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    double sz = size ?? context.insets.xl;
    return AppBtn(
      onPressed: onPressed,
      semanticLabel: semanticLabel,
      minimumSize: Size(sz, sz),
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
    this.size,
    this.iconSize,
    required this.semanticLabel,
  }) : super(key: key);
  final IconData icon;
  final VoidCallback onPressed;
  final BorderSide? border;
  final Color? bgColor;
  final Color? color;
  final String semanticLabel;
  final double? size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    Color defaultColor = context.colors.greyStrong;
    Color iconColor = color ?? context.colors.offWhite;
    return CircleBtn(
      child: Icon(icon, size: iconSize ?? context.insets.md, color: iconColor),
      onPressed: onPressed,
      border: border,
      size: size,
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
    this.semanticLabel,
    this.bgColor,
    this.iconColor,
  }) : super(key: key);

  const BackBtn.close({Key? key, VoidCallback? onPressed, Color? bgColor, Color? iconColor})
      : this(
            key: key,
            icon: Icons.close,
            onPressed: onPressed,
            semanticLabel: 'close',
            bgColor: bgColor,
            iconColor: iconColor);

  final Color? bgColor;
  final Color? iconColor;
  final IconData icon;
  final VoidCallback? onPressed;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return CircleIconBtn(
      icon: icon,
      bgColor: bgColor,
      color: iconColor,
      onPressed: onPressed ?? () => Navigator.pop(context),
      semanticLabel: semanticLabel ?? 'back',
    );
  }

  Widget safe() => _SafeAreaWithPadding(child: this);
}

class _SafeAreaWithPadding extends StatelessWidget {
  const _SafeAreaWithPadding({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.all(context.insets.sm),
        child: child,
      ),
    );
  }
}
