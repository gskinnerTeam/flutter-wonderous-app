part of '../collection_screen.dart';

@immutable
class _CollectionFooter extends StatelessWidget {
  const _CollectionFooter({Key? key, required this.count, required this.total}) : super(key: key);

  final int count;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // TODO SB: Maybe restore this gradient? Need to come up with alternate approach since list can now scroll horizontally
      // Transform.translate(
      //   offset: Offset(0, -$styles.insets.xl),
      //   child: VtGradient(
      //     [$styles.colors.greyStrong.withOpacity(0), $styles.colors.greyStrong],
      //     const [0, 1],
      //     height: $styles.insets.xl,
      //   ),
      // ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.md, vertical: $styles.insets.sm),
        color: $styles.colors.greyStrong,
        child: SafeArea(
          top: false,
          child: Center(
            child: SizedBox(
              width: $styles.sizes.maxContentWidth1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildProgressRow(context),
                  Gap($styles.insets.sm),
                  _buildProgressBar(context),
                  Gap($styles.insets.sm),
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }

  Widget _buildProgressRow(BuildContext context) {
    return Row(children: [
      Text(
        StringUtils.supplant(
          $strings.collectionLabelDiscovered,
          {'{percentage}': (count / total * 100).round().toString()},
        ),
        style: $styles.text.body.copyWith(color: $styles.colors.accent1),
      ),
      Spacer(),
      Text(
        StringUtils.supplant(
          $strings.collectionLabelCount,
          {'{count}': count.toString(), '{total}': total.toString()},
        ),
        style: $styles.text.body.copyWith(color: $styles.colors.offWhite),
      )
    ]);
  }

  Widget _buildProgressBar(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        height: $styles.insets.xs,
        decoration: BoxDecoration(
          color: $styles.colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(1000),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: $styles.colors.accent1,
            borderRadius: BorderRadius.circular(1000),
          ),
        ).animate().fade(duration: 1500.ms, curve: Curves.easeOutExpo).custom(
              builder: (_, m, child) => FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: m * count / total,
                child: child,
              ),
            ),
      ),
    );
  }
}
