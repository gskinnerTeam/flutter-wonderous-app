part of '../artifact_search_screen.dart';

class _ResultTile extends StatelessWidget {
  const _ResultTile({Key? key, required this.onPressed, required this.data}) : super(key: key);

  final void Function(SearchData data) onPressed;
  final SearchData data;

  @override
  Widget build(BuildContext context) {
    final Widget image = AppImage(
      key: ValueKey(data.id),
      image: NetworkImage(data.imageUrlSmall),
      fit: BoxFit.cover,
      scale: 0.5,
      distractor: true,
      color: $styles.colors.greyMedium.withOpacity(0.2),
    );

    return AspectRatio(
      aspectRatio: (data.aspectRatio == 0) ? (data.id % 10) / 15 + 0.6 : max(0.5, data.aspectRatio),
      child: ClipRRect(
        borderRadius: BorderRadius.circular($styles.insets.xs),
        child: AppBtn.basic(
          semanticLabel: data.title,
          onPressed: () => onPressed(data),
          child: Container(
            color: $styles.colors.black,
            width: double.infinity, // force image to fill area
            height: double.infinity,
            child: image,
          ),
        ),
      ),
    );
  }
}
