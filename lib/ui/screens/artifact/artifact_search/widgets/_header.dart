part of '../artifact_search_screen.dart';

class _Header extends StatelessWidget {
  const _Header(this.type, this.title, {Key? key}) : super(key: key);
  final WonderType type;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.greyStrong,
      child: SafeArea(
        child: Row(children: [
          Container(
            width: 64,
            height: 80,
            alignment: Alignment.centerRight,
            child: CircleIconBtn(
              icon: Icons.arrow_back,
              onPressed: () => context.pop(),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              children: [
                Text(
                  title.toUpperCase(),
                  style: context.textStyles.h3.copyWith(color: context.colors.offWhite),
                ),
                Gap(context.insets.xxs),
                Text(
                  type.name.toUpperCase(),
                  style: context.textStyles.title1.copyWith(color: context.colors.accent1),
                ),
              ],
            ),
          ),
          Gap(64),
        ]),
      ),
    );
  }
}
