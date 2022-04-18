part of '../editorial_screen.dart';

class _TitleText extends StatelessWidget {
  const _TitleText(this.data, {Key? key}) : super(key: key);
  final WonderData data;

  @override
  Widget build(BuildContext context) => LightText(
        child: Column(
          children: [
            Gap(context.insets.md),
            Gap(30),
            SeparatedRow(
              padding: EdgeInsets.symmetric(horizontal: context.insets.sm),
              separatorBuilder: () => Gap(context.insets.sm),
              children: [
                Expanded(
                  child: Divider(
                    color: data.type.fgColor,
                  ).fx().scale(curve: Curves.easeOut, delay: 500.ms),
                ),
                Text(
                  data.subTitle.toUpperCase(),
                  style: context.textStyles.body1,
                ).fx().fade(delay: 100.ms),
                Expanded(
                  child: Divider(
                    color: data.type.fgColor,
                  ).fx().scale(curve: Curves.easeOut, delay: 500.ms),
                ),
              ],
            ),
            Gap(context.insets.md),
            Hero(
              tag: '${data.type}-title',
              child: Text(
                data.titleWithBreaks.toUpperCase(),
                style: context.textStyles.h1,
                textAlign: TextAlign.center,
              ),
            ),
            Gap(30),
            Gap(context.insets.md),
          ],
        ),
      );
}
