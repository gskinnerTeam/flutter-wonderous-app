import 'package:wonders/common_libs.dart';

class SimpleHeader extends StatelessWidget {
  const SimpleHeader(this.title, {Key? key, this.subtitle, this.child}) : super(key: key);
  final String title;
  final String? subtitle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.greyStrong,
      child: SafeArea(
        child: Row(children: [
          Container(
            width: context.insets.lg * 2,
            height: context.insets.offset,
            alignment: Alignment.centerRight,
            child: BackBtn(),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              children: [
                Text(
                  title.toUpperCase(),
                  style: context.textStyles.h3.copyWith(color: context.colors.offWhite),
                ),
                if (subtitle != null) Gap(context.insets.xxs),
                if (subtitle != null)
                  Text(
                    subtitle!.toUpperCase(),
                    style: context.textStyles.title1.copyWith(color: context.colors.accent1),
                  ),
              ],
            ),
          ),
          Container(width: context.insets.lg * 2, alignment: Alignment.centerLeft, child: child),
        ]),
      ),
    );
  }
}