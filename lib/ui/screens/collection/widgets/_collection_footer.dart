part of '../collection_screen.dart';

@immutable
class _CollectionFooter extends StatelessWidget {
  const _CollectionFooter({super.key, required this.count, required this.total});

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
          child: CenteredBox(
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
      )
    ]);
  }

  Widget _buildProgressRow(BuildContext context) {
    int percent = (count / total * 100).round();
    return Row(children: [
      Text(
        $strings.collectionLabelDiscovered(percent),
        style: $styles.text.body.copyWith(color: $styles.colors.accent1),
      ),
      Spacer(),
      Text(
        $strings.collectionLabelCount(count, total),
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
        ).maybeAnimate().fade(duration: 1500.animateMs, curve: Curves.easeOutExpo).custom(
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
