part of '../artifact_search_screen.dart';

// TODO: GDS: update the Hero tag.

class _ResultTile extends StatelessWidget {
  const _ResultTile({Key? key, required this.onPressed, required this.data}) : super(key: key);

  final void Function(SearchData data) onPressed;
  final SearchData data;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: context.widthPx * 0.8),
      child: BasicBtn(
        semanticLabel: data.title,
        onPressed: () => onPressed(data),
        child: Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(context.insets.xs),
            child: Hero(
              tag: data.imageUrl,
              child: CachedNetworkImage(
                imageUrl: data.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => _ImagePlaceholder(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.greyMedium.withOpacity(0.1),
        ),
      ),
    );
  }
}