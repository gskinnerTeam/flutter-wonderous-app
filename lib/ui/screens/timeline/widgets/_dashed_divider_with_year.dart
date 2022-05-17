part of '../timeline_screen.dart';

class _DashedDividerWithYear extends StatelessWidget {
  const _DashedDividerWithYear(this.year, {Key? key}) : super(key: key);
  final int year;

  @override
  Widget build(BuildContext context) {
    int yrGap = 10;
    final roundedYr = (year / yrGap).round() * yrGap;
    return Stack(
      children: [
        Center(child: DashedLine()),
        CenterRight(
          child: FractionalTranslation(
            translation: Offset(0, -.5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${roundedYr.abs()}',
                  style: context.text.h2.copyWith(color: context.colors.white, shadows: context.shadows.text),
                ),
                Gap(context.insets.xs),
                Text(
                  StringUtils.getYrSuffix(roundedYr),
                  style: context.text.body.copyWith(
                    color: Colors.white,
                    shadows: context.shadows.textStrong,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
