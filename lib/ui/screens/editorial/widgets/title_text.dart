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
                  ).gTweener.scale(curve: Curves.easeOut).withDelay(.5.seconds),
                ),
                Text(
                  data.subTitle.toUpperCase(),
                  style: context.textStyles.body1,
                ).gTweener.fade().withDelay(.1.seconds),
                Expanded(
                  child: Divider(
                    color: data.type.fgColor,
                  ).gTweener.scale(curve: Curves.easeOut).withDelay(.5.seconds),
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
