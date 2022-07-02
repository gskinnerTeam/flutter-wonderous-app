part of '../collection_screen.dart';

@immutable
class _NewlyDiscoveredRow extends StatelessWidget {
  const _NewlyDiscoveredRow({Key? key, this.count = 0, required this.onPressed}) : super(key: key);

  final int count;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (count == 0) return SizedBox.shrink();
    return AppBtn.basic(
      semanticLabel: '$count new item${count == 1 ? '' : 's'} to explore. Scroll to new item.',
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        color: $styles.colors.black,
        padding: EdgeInsets.symmetric(vertical: $styles.insets.xs),
        child: Text(
          '$count new item${count == 1 ? '' : 's'} to explore',
          textAlign: TextAlign.center,
          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
          style: $styles.text.bodySmallBold.copyWith(color: $styles.colors.accent1),
        ),
      ),
    );
  }
}
