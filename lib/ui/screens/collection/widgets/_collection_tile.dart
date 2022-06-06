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
      color: $styles.colors.black,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.6,
          heightFactor: 0.6,
          child: Image(image: collectible.icon, color: $styles.colors.greyStrong),
        ),
      ),
    );
  }

  Widget _buildFound(BuildContext context, CollectibleData collectible, int state) {
    final bool isNew = state == CollectibleState.discovered;
    Widget content = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: $styles.colors.black,
        border: isNew ? Border.all(color: $styles.colors.accent1, width: 3) : null,
        boxShadow:
            !isNew ? null : [BoxShadow(color: $styles.colors.accent1.withOpacity(0.6), blurRadius: $styles.insets.sm)],
      ),
      child: ImageFade(
        image: NetworkImage(collectible.imageUrlSmall),
        duration: $styles.times.fast,
        alignment: Alignment.center,
        fit: BoxFit.cover,
      ),
    );

    // TODO: GDS: hero is disabled for now, since it doesn't play well with Cupertino transitions or the double nav pop.
    //if (heroTag != null) content = Hero(tag: heroTag!, child: content);
    return AppBtn.basic(
      semanticLabel: collectible.title,
      onPressed: () => onPressed(collectible),
      child: content,
    );
  }
}
