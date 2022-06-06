part of '../artifact_search_screen.dart';

class _ResultTile extends StatelessWidget {
  const _ResultTile({Key? key, required this.onPressed, required this.data}) : super(key: key);

  final void Function(SearchData data) onPressed;
  final SearchData data;

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      color: $styles.colors.black,
      width: double.infinity,
      child: ImageFade(
        key: ValueKey(data.id),
        image: NetworkImage(data.imageUrl),
        duration: $styles.times.fast,
        syncDuration: 0.ms,
        fit: BoxFit.cover,
        errorBuilder: (ctx, __) => Center(
          child: Icon(
            Icons.image_not_supported,
            color: $styles.colors.greyStrong,
            size: $styles.insets.xl,
          ),
        ),
      ),
    );

    return AspectRatio(
      aspectRatio: (data.aspectRatio == 0) ? (data.id % 10) / 15 + 0.6 : max(0.5, data.aspectRatio),
      child: ClipRRect(
        borderRadius: BorderRadius.circular($styles.insets.xs),
        child: AppBtn.basic(
          semanticLabel: data.title,
          onPressed: () => onPressed(data),
          child: content,
        ),
      ),
    );
  }
}
