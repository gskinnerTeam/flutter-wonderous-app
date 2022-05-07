part of '../collection_screen.dart';

class _CollectionTile extends StatelessWidget {
  const _CollectionTile({
    Key? key,
    required this.collectible,
    required this.state,
    required this.onPressed,
    this.heroTag,
  }) : super(key: key);

  final CollectibleData collectible;
  final ValueSetter<CollectibleData> onPressed;
  final int state;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: state == CollectibleState.lost
          ? _buildHidden(context, collectible)
          : _buildFound(context, collectible, state),
    );
  }

  Widget _buildHidden(BuildContext context, CollectibleData collectible) {
    return Container(
      color: context.colors.black,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.6,
          heightFactor: 0.6,
          child: Image(image: collectible.icon, color: context.colors.greyStrong),
        ),
      ),
    );
  }

  Widget _buildFound(BuildContext context, CollectibleData collectible, int state) {
    final bool isNew = state == CollectibleState.discovered;
    Widget content = Container(
      decoration: BoxDecoration(
        color: context.colors.black,
        border: isNew ? Border.all(color: context.colors.accent1, width: 3) : null,
        boxShadow:
            !isNew ? null : [BoxShadow(color: context.colors.accent1.withOpacity(0.6), blurRadius: context.insets.sm)],
      ),
      child: CachedNetworkImage(
        alignment: Alignment.center,
        imageUrl: collectible.imageUrlSmall,
        fit: BoxFit.cover,
      ),
    );
    if (heroTag != null) content = Hero(tag: heroTag!, child: content);
    return Semantics(
      label: collectible.title,
      button: true,
      container: true,
      child: GestureDetector(onTap: () => onPressed(collectible), child: content),
    );
  }
}
