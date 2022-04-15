import 'package:wonders/common_libs.dart';

/// Shared methods across button types
_buildIcon(BuildContext context, IconData icon, {required bool isSecondary, required double? size}) =>
    Icon(icon, color: isSecondary ? context.colors.black : context.colors.offWhite, size: size ?? 18);

/// The core button that drives all other buttons.
class AppBtn extends StatelessWidget {
  const AppBtn({
    Key? key,
    required this.children,
    required this.onPressed,
    this.padding,
    this.expand = false,
    this.isSecondary = false,
    this.bgColor,
  }) : super(key: key);
  final List<Widget> children;
  final VoidCallback onPressed;
  final EdgeInsets? padding;
  final bool expand;
  final bool isSecondary;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    Color defaultColor = isSecondary ? context.colors.white : context.colors.greyStrong;
    Color textColor = isSecondary ? context.colors.black : context.colors.white;
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: bgColor ?? defaultColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.corners.md)),
          padding: padding ?? EdgeInsets.all(context.insets.sm),
        ),
        child: DefaultTextStyle(
          style: DefaultTextStyle.of(context).style.copyWith(color: textColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            children: children,
          ),
        ));
  }
}

/// //////////////////////////////////////////////////
/// AppButton Derivatives
/// //////////////////////////////////////////////////

class AppIconBtn extends StatelessWidget {
  const AppIconBtn(
    this.icon, {
    Key? key,
    required this.onPressed,
    this.padding,
    this.expand = false,
    this.isSecondary = false,
    this.size,
  }) : super(key: key);
  final IconData icon;
  final double? size;
  final VoidCallback onPressed;
  final EdgeInsets? padding;
  final bool expand;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    return AppBtn(
      onPressed: onPressed,
      padding: padding,
      expand: expand,
      isSecondary: isSecondary,
      children: [
        _buildIcon(context, icon, isSecondary: isSecondary, size: size),
      ],
    );
  }
}

class AppTextIconBtn extends StatelessWidget {
  const AppTextIconBtn(
    this.text,
    this.icon, {
    Key? key,
    required this.onPressed,
    this.padding,
    this.expand = false,
    this.isSecondary = false,
    this.iconSize,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final double? iconSize;
  final VoidCallback onPressed;
  final EdgeInsets? padding;
  final bool expand;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    return AppBtn(
      onPressed: onPressed,
      padding: padding,
      expand: expand,
      isSecondary: isSecondary,
      children: [
        Text(text, style: context.textStyles.button),
        Gap(context.insets.xs),
        _buildIcon(context, icon, isSecondary: isSecondary, size: iconSize),
      ],
    );
  }
}

class AppTextBtn extends StatelessWidget {
  const AppTextBtn(
    this.text, {
    Key? key,
    required this.onPressed,
    this.padding,
    this.expand = false,
    this.isSecondary = false,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final EdgeInsets? padding;
  final bool expand;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    return AppBtn(
      onPressed: onPressed,
      padding: padding,
      expand: expand,
      isSecondary: isSecondary,
      children: [
        Text(text, style: context.textStyles.button),
      ],
    );
  }
}
