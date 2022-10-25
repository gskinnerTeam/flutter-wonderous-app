import 'package:wonders/common_libs.dart';

class SimpleHeader extends StatelessWidget {
  const SimpleHeader(this.title,
      {Key? key, this.subtitle, this.child, this.showBackBtn = true, this.isTransparent = false, this.onBack})
      : super(key: key);
  final String title;
  final String? subtitle;
  final Widget? child;
  final bool showBackBtn;
  final bool isTransparent;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isTransparent ? Colors.transparent : $styles.colors.black,
      child: SafeArea(
        bottom: false,
        child: Row(children: [
          if (showBackBtn) BackBtn(onPressed: onBack).safe(),
          Flexible(
            fit: FlexFit.tight,
            child: MergeSemantics(
              child: Semantics(
                header: true,
                child: Column(
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
          ),
          if (showBackBtn) Container(width: $styles.insets.lg * 2, alignment: Alignment.centerLeft, child: child),
        ]),
      ),
    );
  }
}
