part of '../collection_screen.dart';

// TODO: GDS: Semantics, possibly use BasicBtn

class _CollectionTile extends StatelessWidget {
  const _CollectionTile({
    Key? key,
    required this.collectible,
    required this.state,
    required this.onPressed,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: GDS: remove for production. Useful for videos / screenshots:
    /*
    state = rnd.getBool(0.67) ? 2 : 0;
    if (collectible.id == '701645') state = 1;
    */
    return RepaintBoundary(
      child: state == CollectibleState.lost
          ? _buildHidden(context, collectible)
          : _buildFound(context, collectible, state),
    );
  }

  final CollectibleData collectible;
  final ValueSetter<CollectibleData> onPressed;
  final int state;
  final String? heroTag;

  Widget _buildHidden(BuildContext context, CollectibleData collectible) {
    final Color fadedGrey = context.colors.greyMedium.withOpacity(0.25);
    return Container(
      decoration: BoxDecoration(
        color: context.colors.black,
        border: Border.all(color: fadedGrey),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [context.colors.greyStrong, context.colors.black],
          stops: const [0, 1],
        ),
      ),
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.6,
          heightFactor: 0.6,
          child: Image(image: collectible.icon, color: fadedGrey),
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
    return BasicBtn(semanticLabel: 'Collectible', onPressed: () => onPressed(collectible), child: content);
  }
}
