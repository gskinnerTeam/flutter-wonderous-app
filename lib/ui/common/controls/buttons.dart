import 'package:wonders/common_libs.dart';

/// Shared methods across button types
Widget _buildIcon(BuildContext context, IconData icon, {required bool isSecondary, required double? size}) =>
    Icon(icon, color: isSecondary ? context.colors.black : context.colors.offWhite, size: size ?? 18);

/// The core button that drives all other buttons.
class AppBtn extends StatefulWidget {
  const AppBtn(
      {Key? key,
      required this.children,
      required this.onPressed,
      this.padding,
      this.expand = false,
      this.isSecondary = false,
      this.bgColor,
      this.semanticLabel = ''})
      : super(key: key);
  final List<Widget> children;
  final VoidCallback onPressed;
  final EdgeInsets? padding;
  final bool expand;
  final bool isSecondary;
  final Color? bgColor;
  final String semanticLabel;

  @override
  State<AppBtn> createState() => _AppBtnState();
}

class _AppBtnState extends State<AppBtn> {
  bool _tapDown = false;
  @override
  Widget build(BuildContext context) {
    Color defaultColor = widget.isSecondary ? context.colors.white : context.colors.greyStrong;
    Color textColor = widget.isSecondary ? context.colors.black : context.colors.white;
    return Semantics(
      label: widget.semanticLabel,
      button: true,
      container: true,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _tapDown = true),
        onTapUp: (_) => setState(() => _tapDown = false),
        onTapCancel: () => setState(() => _tapDown = false),
        child: Opacity(
          opacity: _tapDown ? .7 : 1,
          child: TextButton(
              onPressed: widget.onPressed,
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
      ),
    );
  }
}

/// //////////////////////////////////////////////////
/// AppButton Derivatives
/// //////////////////////////////////////////////////

class BasicBtn extends StatelessWidget {
  const BasicBtn({Key? key, required this.child, required this.label, required this.onPressed}) : super(key: key);
  final Widget child;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBtn(
      children: [child],
      onPressed: onPressed,
      semanticLabel: label,
      padding: EdgeInsets.zero,
      bgColor: Colors.transparent,
    );
  }
}

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
