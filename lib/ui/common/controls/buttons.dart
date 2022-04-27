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
      this.circular = false,
      this.minimumSize,
      this.bgColor,
      this.border,
      required this.semanticLabel})
      : super(key: key);
  final List<Widget> children;
  final VoidCallback onPressed;
  final String semanticLabel;
  final EdgeInsets? padding;
  final bool expand;
  final bool isSecondary;
  final BorderSide? border;
  final Color? bgColor;
  final bool circular;
  final Size? minimumSize;

  @override
  State<AppBtn> createState() => _AppBtnState();
}

class _AppBtnState extends State<AppBtn> {
  bool _tapDown = false;
  @override
  Widget build(BuildContext context) {
    Color defaultColor = widget.isSecondary ? context.colors.white : context.colors.greyStrong;
    Color textColor = widget.isSecondary ? context.colors.black : context.colors.white;
    BorderSide border = widget.border ?? BorderSide.none;

    Widget button = GestureDetector(
      onTapDown: (_) => setState(() => _tapDown = true),
      onTapUp: (_) => setState(() => _tapDown = false),
      onTapCancel: () => setState(() => _tapDown = false),
      child: Opacity(
        opacity: _tapDown ? .7 : 1,
        child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
            minimumSize: widget.minimumSize ?? Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            splashFactory: NoSplash.splashFactory,
            backgroundColor: widget.bgColor ?? defaultColor,
            shape: widget.circular
                ? CircleBorder(side: border)
                : RoundedRectangleBorder(side: border, borderRadius: BorderRadius.circular(context.corners.md)),
            padding: widget.padding ?? EdgeInsets.all(context.insets.sm),
          ),
          child: DefaultTextStyle(
            style: DefaultTextStyle.of(context).style.copyWith(color: textColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
              children: widget.children,
            ),
          ),
        ),
      ),
    );
    if (widget.circular) button = ClipRRect(borderRadius: BorderRadius.circular(99), child: button);
    button = Semantics(label: widget.semanticLabel, button: true, container: true, child: button);
    return button;
  }
}

/// //////////////////////////////////////////////////
/// AppButton Derivatives
/// //////////////////////////////////////////////////

class BasicBtn extends StatelessWidget {
  const BasicBtn(
      {Key? key, required this.child, required this.semanticLabel, required this.onPressed, this.expand = false})
      : super(key: key);
  final Widget child;
  final String semanticLabel;
  final VoidCallback onPressed;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return AppBtn(
      children: [expand ? Expanded(child: child) : child],
      onPressed: onPressed,
      semanticLabel: semanticLabel,
      padding: EdgeInsets.zero,
      bgColor: Colors.transparent,
      expand: expand,
    );
  }
}

class AppIconBtn extends StatelessWidget {
  const AppIconBtn(
    this.icon, {
    Key? key,
    required this.onPressed,
    required this.semanticLabel,
    this.padding,
    this.expand = false,
    this.isSecondary = false,
    this.size,
  }) : super(key: key);
  final IconData icon;
  final double? size;
  final VoidCallback onPressed;
  final String semanticLabel;
  final EdgeInsets? padding;
  final bool expand;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    return AppBtn(
      onPressed: onPressed,
      semanticLabel: semanticLabel,
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
      semanticLabel: text,
      children: [
        Text(text, style: context.textStyles.btn),
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
      semanticLabel: text,
      children: [
        Text(text.toUpperCase(), style: context.textStyles.btn),
      ],
    );
  }
}
