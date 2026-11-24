import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/app_icons.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    this.title,
    this.subtitle,
    this.showBackBtn = true,
    this.isTransparent = false,
    this.onBack,
    this.trailing,
    this.backIcon = AppIcons.prev,
    this.backBtnSemantics,
  });
  final String? title;
  final String? subtitle;
  final bool showBackBtn;
  final AppIcons backIcon;
  final String? backBtnSemantics;
  final bool isTransparent;
  final VoidCallback? onBack;
  final Widget Function(BuildContext context)? trailing;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isTransparent ? Colors.transparent : $styles.colors.black,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 64 * $styles.scale,
          // NavigationToolbar keeps the title centred while preventing it from overlapping the back button or
          // trailing widget. At large text scales the title shrinks to fit the remaining space instead of overflowing.
          child: NavigationToolbar(
            leading: showBackBtn
                ? Padding(
                    padding: EdgeInsets.only(left: $styles.insets.sm),
                    // NavigationToolbar stretches leading to the full height, so centre the button vertically within it
                    // (widthFactor keeps it only as wide as the button, so it doesn't take the title's space).
                    child: Align(
                      widthFactor: 1,
                      child: BackBtn(onPressed: onBack, icon: backIcon, semanticLabel: backBtnSemantics),
                    ),
                  )
                : null,
            trailing: trailing != null
                ? Padding(
                    padding: EdgeInsets.only(right: $styles.insets.sm),
                    // Text-based trailing widgets (eg. the locale switcher) shrink to fit the header at large text scales.
                    child: FittedBox(fit: BoxFit.scaleDown, child: trailing!.call(context)),
                  )
                : null,
            middleSpacing: $styles.insets.xs,
            middle: MergeSemantics(
              child: Semantics(
                header: true,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title != null)
                        Text(
                          title!.toUpperCase(),
                          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                          style: $styles.text.h4.copyWith(
                            color: $styles.colors.offWhite,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      if (subtitle != null)
                        Text(
                          subtitle!.toUpperCase(),
                          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                          style: $styles.text.title1.copyWith(color: $styles.colors.accent1),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
