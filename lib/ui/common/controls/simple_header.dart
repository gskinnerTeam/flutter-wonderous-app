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
      color: isTransparent ? Colors.transparent : context.colors.greyStrong,
      child: SafeArea(
        bottom: false,
        child: Row(children: [
          if (showBackBtn) BackBtn(onPressed: onBack).safe(),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              children: [
                if (!showBackBtn) Gap(context.insets.xs),
                Text(
                  title.toUpperCase(),
                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  style: context.textStyles.h4.copyWith(color: context.colors.offWhite),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!.toUpperCase(),
                    textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                    style: context.textStyles.title1.copyWith(color: context.colors.accent1),
                  ),
                if (!showBackBtn) Gap(context.insets.md),
              ],
            ),
          ),
          if (showBackBtn) Container(width: context.insets.lg * 2, alignment: Alignment.centerLeft, child: child),
        ]),
      ),
    );
  }
}
