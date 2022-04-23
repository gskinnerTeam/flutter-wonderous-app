part of '../artifact_search_screen.dart';

class _ResultTile extends StatelessWidget {
  const _ResultTile({Key? key, required this.onPressed, required this.data}) : super(key: key);

  final void Function(ArtifactData data) onPressed;
  final ArtifactData data;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: context.widthPx),
      child: BasicBtn(
        label: data.title,
        onPressed: () => onPressed(data),
        child: Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(context.insets.xs),
            child: Hero(
              tag: data.image,
              child: CachedNetworkImage(
                imageUrl: data.image,
                fit: BoxFit.cover,
                memCacheWidth: context.widthPx ~/ 2,
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
      child: Center(child: AppLoader()),
    );
  }
}