part of '../collection_screen.dart';

@immutable
class _CollectionFooter extends StatelessWidget {
  const _CollectionFooter({Key? key, required this.count, required this.total}) : super(key: key);

  final int count;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // ensure the gradient doesn't block interactions with the list layered below it:
      Transform.translate(
        offset: Offset(0, -context.insets.xl),
        child: VtGradient(
          [context.colors.greyStrong.withOpacity(0), context.colors.greyStrong],
          const [0, 1],
          height: context.insets.xl,
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: context.insets.md, vertical: context.insets.sm),
        color: context.colors.greyStrong,
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProgressRow(context),
              Gap(context.insets.sm),
              _buildProgressBar(context),
              Gap(context.insets.sm),
            ],
          ),
        ),
      )
    ]);
  }

  Widget _buildProgressRow(BuildContext context) {
    return Row(children: [
      Text(
        '${(count / total * 100).round()}% discovered',
        style: context.textStyles.body.copyWith(color: context.colors.accent1),
      ),
      Spacer(),
      Text(
        '$count of $total',
        style: context.textStyles.body.copyWith(color: context.colors.offWhite),
      )
    ]);
  }

  Widget _buildProgressBar(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        height: context.insets.xs,
        decoration: BoxDecoration(
          color: context.colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(1000),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.accent1,
            borderRadius: BorderRadius.circular(1000),
          ),
        ).fx().fade(duration: 1500.ms, curve: Curves.easeOutExpo).custom((_, m, child) =>
            FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: m * count / total, child: child)),
      ),
    );
  }
}
