part of '../artifact_search_screen.dart';

class _ResultTile extends StatelessWidget {
  const _ResultTile({Key? key, required this.onPressed, required this.data}) : super(key: key);

  final void Function(SearchData data) onPressed;
  final SearchData data;

  @override
  Widget build(BuildContext context) {
    Color iconColor = context.colors.greyStrong;
    double iconSize = context.insets.xl;
    final Widget content = ColoredBox(
      color: context.colors.black,
      child: ImageFade(
        image: NetworkImage(data.imageUrl),
        fadeDuration: context.times.fast,
        fit: BoxFit.cover,
        errorBuilder: (ctx, __) => Center(
          child: Icon(
            Icons.image_not_supported,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ),
    );

    return AspectRatio(
      aspectRatio: (data.aspectRatio == 0) ? (data.id % 10) / 15 + 0.6 : max(0.5, data.aspectRatio),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.insets.xs),
        child: BasicBtn(
          semanticLabel: data.title,
          onPressed: () => onPressed(data),
          child: Expanded(child: content),
        ),
      ),
    );
  }
}
