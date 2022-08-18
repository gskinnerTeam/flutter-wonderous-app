import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/app_icons.dart';

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

  static double defaultSize = 48;

  final VoidCallback onPressed;
  final Color? bgColor;
  final BorderSide? border;
  final Widget child;
  final double? size;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    double sz = size ?? defaultSize;
    return AppBtn(
      onPressed: onPressed,
      semanticLabel: semanticLabel,
      minimumSize: Size(sz, sz),
      padding: EdgeInsets.zero,
      circular: true,
      bgColor: bgColor,
      border: border,
      child: child,
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

  //TODO: Reduce size if design re-exports icon-images without padding
  static double defaultSize = 28;

  final AppIcons icon;
  final VoidCallback onPressed;
  final BorderSide? border;
  final Color? bgColor;
  final Color? color;
  final String semanticLabel;
  final double? size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    Color defaultColor = $styles.colors.greyStrong;
    Color iconColor = color ?? $styles.colors.offWhite;
    return CircleBtn(
      onPressed: onPressed,
      border: border,
      size: size,
      bgColor: bgColor ?? defaultColor,
      semanticLabel: semanticLabel,
      child: AppIcon(icon, size: iconSize ?? defaultSize, color: iconColor),
    );
  }

  Widget safe() => _SafeAreaWithPadding(child: this);
}

class BackBtn extends StatelessWidget {
  const BackBtn({
    Key? key,
    this.icon = AppIcons.prev,
    this.onPressed,
    this.semanticLabel,
    this.bgColor,
    this.iconColor,
  }) : super(key: key);

  final Color? bgColor;
  final Color? iconColor;
  final AppIcons icon;
  final VoidCallback? onPressed;
  final String? semanticLabel;

  BackBtn.close({Key? key, VoidCallback? onPressed, Color? bgColor, Color? iconColor})
      : this(
            key: key,
            icon: AppIcons.close,
            onPressed: onPressed,
            semanticLabel: $strings.circleButtonsSemanticClose,
            bgColor: bgColor,
            iconColor: iconColor);
  @override
  Widget build(BuildContext context) {
    return CircleIconBtn(
      icon: icon,
      bgColor: bgColor,
      color: iconColor,
      onPressed: onPressed ?? () => Navigator.pop(context),
      semanticLabel: semanticLabel ?? $strings.circleButtonsSemanticBack,
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
        padding: EdgeInsets.all($styles.insets.sm),
        child: child,
      ),
    );
  }
}
