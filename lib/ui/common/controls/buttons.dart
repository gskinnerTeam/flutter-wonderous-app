import 'package:flutter/foundation.dart';
import 'package:wonders/common_libs.dart';

/// Shared methods across button types
Widget _buildIcon(BuildContext context, IconData icon, {required bool isSecondary, required double? size}) =>
    Icon(icon, color: isSecondary ? $styles.colors.black : $styles.colors.offWhite, size: size ?? 18);

/// The core button that drives all other buttons.
class AppBtn extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  AppBtn({
    Key? key,
    required this.onPressed,
    required this.semanticLabel,
    this.child,
    this.padding,
    this.expand = false,
    this.isSecondary = false,
    this.circular = false,
    this.minimumSize,
    this.bgColor,
    this.border,
  })  : _builder = null,
        super(key: key);

  AppBtn.from({
    Key? key,
    required this.onPressed,
    this.padding,
    this.expand = false,
    this.isSecondary = false,
    this.minimumSize,
    this.bgColor,
    this.border,
    String? semanticLabel,
    String? text,
    IconData? icon,
    double? iconSize,
  })  : child = null,
        circular = false,
        super(key: key) {
    if (semanticLabel == null && text == null) throw ('AppBtn.from must include either text or semanticLabel');
    this.semanticLabel = semanticLabel ?? text ?? '';
    _builder = (context) {
      if (text == null && icon == null) return SizedBox.shrink();
      Text? txt = text == null
          ? null
          : Text(text.toUpperCase(),
              style: $styles.text.btn, textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false));
      Widget? icn = icon == null ? null : _buildIcon(context, icon, isSecondary: isSecondary, size: iconSize);
      if (txt != null && icn != null) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [txt, Gap($styles.insets.xs), icn],
        );
      } else {
        return (txt ?? icn)!;
      }
    };
  }

  // ignore: prefer_const_constructors_in_immutables
  AppBtn.basic({
    Key? key,
    required this.onPressed,
    required this.semanticLabel,
    this.child,
    this.padding = EdgeInsets.zero,
    this.isSecondary = false,
    this.circular = false,
    this.minimumSize,
  })  : expand = false,
        bgColor = Colors.transparent,
        border = null,
        _builder = null,
        super(key: key);

  // interaction:
  final VoidCallback onPressed;
  late final String semanticLabel;

  // content:
  late final Widget? child;
  late final WidgetBuilder? _builder;

  // layout:
  final EdgeInsets? padding;
  final bool expand;
  final bool circular;
  final Size? minimumSize;

  // style:
  final bool isSecondary;
  final BorderSide? border;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    Color defaultColor = isSecondary ? $styles.colors.white : $styles.colors.greyStrong;
    Color textColor = isSecondary ? $styles.colors.black : $styles.colors.white;
    BorderSide side = border ?? BorderSide.none;

    Widget content = _builder?.call(context) ?? child ?? SizedBox.shrink();
    if (expand) content = Center(child: content);

    Widget button = TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: minimumSize ?? Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashFactory: NoSplash.splashFactory,
        backgroundColor: bgColor ?? defaultColor,
        shape: circular
            ? CircleBorder(side: side)
            : RoundedRectangleBorder(side: side, borderRadius: BorderRadius.circular($styles.corners.md)),
        padding: padding ?? EdgeInsets.all($styles.insets.md),
      ),
      child: DefaultTextStyle(
        style: DefaultTextStyle.of(context).style.copyWith(color: textColor),
        child: content,
      ),
    );

    return _ButtonDecorator(button, semanticLabel);
  }
}

/// //////////////////////////////////////////////////
/// _ButtonDecorator
/// Applies the "add-on" behaviours common to all app buttons: press effect, semantics, haptics.
/// //////////////////////////////////////////////////
class _ButtonDecorator extends StatefulWidget {
  const _ButtonDecorator(this.child, this.semanticLabel, {Key? key}) : super(key: key);
  final Widget child;
  final String semanticLabel;

  @override
  State<_ButtonDecorator> createState() => _ButtonDecoratorState();
}

class _ButtonDecoratorState extends State<_ButtonDecorator> {
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel,
      button: true,
      container: true,
      child: GestureDetector(
        excludeFromSemantics: true,
        onTapDown: (_) => setState(() => _isDown = true),
        onTapUp: (_) {
          if (defaultTargetPlatform == TargetPlatform.android) HapticFeedback.lightImpact();
          setState(() => _isDown = false);
        },
        onTapCancel: () => setState(() => _isDown = false),
        behavior: HitTestBehavior.translucent,
        child: Opacity(
          opacity: _isDown ? .7 : 1,
          child: ExcludeSemantics(child: widget.child),
        ),
      ),
    );
  }
}
