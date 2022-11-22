import 'package:wonders/common_libs.dart';

class SimpleHeader extends StatelessWidget {
  const SimpleHeader(this.title,
      {Key? key, this.subtitle, this.showBackBtn = true, this.isTransparent = false, this.onBack, this.trailing})
      : super(key: key);
  final String title;
  final String? subtitle;
  final bool showBackBtn;
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
          height: 64,
          child: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: Row(children: [
                    Gap($styles.insets.sm),
                    if (showBackBtn) BackBtn(onPressed: onBack),
                    Spacer(),
                    if (trailing != null) trailing!.call(context),
                    Gap($styles.insets.sm),
                    //if (showBackBtn) Container(width: $styles.insets.lg * 2, alignment: Alignment.centerLeft, child: child),
                  ]),
                ),
              ),
              MergeSemantics(
                child: Semantics(
                  header: true,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!showBackBtn) Gap($styles.insets.xs),
                        Text(
                          title.toUpperCase(),
                          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                          style: $styles.text.h4.copyWith(color: $styles.colors.offWhite, fontWeight: FontWeight.w500),
                        ),
                        if (subtitle != null)
                          Text(
                            subtitle!.toUpperCase(),
                            textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                            style: $styles.text.title1.copyWith(color: $styles.colors.accent1),
                          ),
                        if (!showBackBtn) Gap($styles.insets.md),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
