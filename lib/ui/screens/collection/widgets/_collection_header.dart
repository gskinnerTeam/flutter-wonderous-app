part of '../collection_screen.dart';

@immutable
class _CollectionHeader extends StatelessWidget {
  const _CollectionHeader({Key? key, required this.newCount}) : super(key: key);

  final int newCount;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _buildTitleRow(context),
        _buildNewItemsRow(context),
      ]),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(children: [
      Container(
        width: context.insets.lg * 2,
        height: context.insets.offset,
        alignment: Alignment.centerRight,
        child: CircleIconBtn(
          icon: Icons.arrow_back,
          onPressed: () => context.pop(),
        ),
      ),
      Flexible(
        fit: FlexFit.tight,
        child: Text(
          'Collection'.toUpperCase(),
          textAlign: TextAlign.center,
          style: context.textStyles.h3.copyWith(color: context.colors.offWhite),
        ),
      ),
      Gap(context.insets.lg * 2),
    ]);
  }

  Widget _buildNewItemsRow(BuildContext context) {
    if (newCount == 0) return SizedBox.shrink();
    return Container(
      color: context.colors.black,
      padding: EdgeInsets.symmetric(vertical: context.insets.xs),
      child: Text(
        '$newCount new item${newCount == 1 ? '' : 's'} to explore',
        textAlign: TextAlign.center,
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
        style: context.textStyles.body2.copyWith(color: context.colors.accent1),
      ),
    );
  }
}
