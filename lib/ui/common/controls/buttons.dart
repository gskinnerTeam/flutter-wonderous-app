import 'package:wonders/common_libs.dart';

/// Shared methods across button types
Widget _buildIcon(BuildContext context, IconData icon, {required bool isSecondary, required double? size}) =>
    Icon(icon, color: isSecondary ? context.colors.black : context.colors.offWhite, size: size ?? 18);

/// The core button that drives all other buttons.
class AppBtn extends StatefulWidget {
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
  State<AppBtn> createState() => _AppBtnState();
}

class _AppBtnState extends State<AppBtn> {
  bool _tapDown = false;
  @override
  Widget build(BuildContext context) {
    Color defaultColor = widget.isSecondary ? context.colors.white : context.colors.greyStrong;
    Color textColor = widget.isSecondary ? context.colors.black : context.colors.white;
    return GestureDetector(
      onTapDown: (_) => setState(() => _tapDown = true),
      onTapUp: (_) => setState(() => _tapDown = false),
      onTapCancel: () => setState(() => _tapDown = false),
      child: Opacity(
        opacity: _tapDown ? .7 : 1,
        child: TextButton(
            onPressed: widget.onPressed,
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              backgroundColor: widget.bgColor ?? defaultColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.corners.md)),
              padding: widget.padding ?? EdgeInsets.all(context.insets.sm),
            ),
            child: DefaultTextStyle(
              style: DefaultTextStyle.of(context).style.copyWith(color: textColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
                children: widget.children,
              ),
            )),
      ),
    );
  }
}

// todo: this has a margin around it for some reason.
class CloseBtn extends StatelessWidget {
  const CloseBtn({
    Key? key,
    required this.onPressed,
    this.padding,
    this.bgColor,
    this.color,
  }) : super(key: key);
  final VoidCallback onPressed;
  final double? padding;
  final Color? bgColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Color defaultColor = context.colors.greyStrong;
    Color iconColor = color ?? context.colors.offWhite;
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: bgColor ?? defaultColor,
          shape: CircleBorder(),
          padding: EdgeInsets.all(padding ?? context.insets.xs * 1.5),
        ),
        child: Icon(Icons.close, size: 24, color: iconColor,),
      );
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
        Text(text.toUpperCase(), style: context.textStyles.button),
      ],
    );
  }
}
