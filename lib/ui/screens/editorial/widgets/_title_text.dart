part of '../editorial_screen.dart';

class _TitleText extends StatelessWidget {
  const _TitleText(this.data, {Key? key, required this.scroller}) : super(key: key);
  final WonderData data;
  final ScrollController scroller;

  @override
  Widget build(BuildContext context) => DefaultTextColor(
        color: context.colors.offWhite,
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
                  ).animate().scale(curve: Curves.easeOut, delay: 500.ms),
                ),
                Text(
                  data.subTitle.toUpperCase(),
                  style: context.textStyles.title2,
                ).animate().fade(delay: 100.ms),
                Expanded(
                  child: Divider(
                    color: data.type.fgColor,
                  ).animate().scale(curve: Curves.easeOut, delay: 500.ms),
                ),
              ],
            ),
            Gap(context.insets.md),
            WonderTitleText(data),
            Gap(context.insets.xs),
            Text(
              data.regionTitle.toUpperCase(),
              style: context.textStyles.title1,
              textAlign: TextAlign.center,
            ),
            Gap(context.insets.md),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.insets.md),
              child: AnimatedBuilder(
                animation: scroller,
                builder: (_, __) => CompassDivider(
                  isExpanded: scroller.position.pixels <= 0,
                  linesColor: data.type.fgColor,
                  compassColor: context.colors.offWhite,
                ),
              ),
            ),
            Gap(context.insets.sm),
            Text(
              '${StringUtils.formatYr(data.startYr)} - ${StringUtils.formatYr(data.endYr)}',
              style: context.textStyles.h4,
              textAlign: TextAlign.center,
            ),
            Gap(context.insets.sm),
          ],
        ),
      );
}
