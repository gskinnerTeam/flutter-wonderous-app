part of '../collection_screen.dart';

@immutable
class _NewlyDiscoveredRow extends StatelessWidget {
  const _NewlyDiscoveredRow({Key? key, this.count = 0, required this.onPressed}) : super(key: key);

  final int count;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (count == 0) return SizedBox.shrink();
    return BasicBtn(
      expand: true,
      semanticLabel: 'Scroll to new item',
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        color: context.colors.black,
        padding: EdgeInsets.symmetric(vertical: context.insets.xs),
        child: Text(
          '$count new item${count == 1 ? '' : 's'} to explore',
          textAlign: TextAlign.center,
          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
          style: context.textStyles.bodySmallBold.copyWith(color: context.colors.accent1),
        ),
      ),
    );
  }
}
