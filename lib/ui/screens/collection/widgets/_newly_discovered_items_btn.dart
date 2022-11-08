part of '../collection_screen.dart';

@immutable
class _NewlyDiscoveredItemsBtn extends StatelessWidget {
  const _NewlyDiscoveredItemsBtn({Key? key, this.count = 0, required this.onPressed}) : super(key: key);

  final int count;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (count == 0) return SizedBox.shrink();

    return AppBtn.basic(
      semanticLabel: StringUtils.supplant(
        $strings.newlyDiscoveredSemanticNew,
        {'{count}': count.toString(), '{plural}': count == 1 ? '' : 's'},
      ),
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        color: $styles.colors.black,
        padding: EdgeInsets.symmetric(vertical: $styles.insets.xs),
        child: Text(
          StringUtils.supplant(
            $strings.newlyDiscoveredLabelNew,
            {'{count}': count.toString(), '{plural}': count == 1 ? '' : 's'},
          ),
          textAlign: TextAlign.center,
          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
          style: $styles.text.bodySmallBold.copyWith(color: $styles.colors.accent1),
        ),
      ),
    );
  }
}
