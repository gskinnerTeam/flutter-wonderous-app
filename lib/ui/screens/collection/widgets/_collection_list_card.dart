part of '../collection_screen.dart';

class _CollectionListCard extends StatelessWidget with GetItMixin {
  _CollectionListCard({super.key, this.width, this.height, required this.data, required this.fromId});

  final double? width;
  final double? height;
  final WonderData data;
  final String fromId;

  void _showDetails(BuildContext context, CollectibleData collectible) {
    context.go(ScreenPaths.artifact(collectible.artifactId));
    Future.delayed(300.ms).then((_) => collectiblesLogic.setState(collectible.id, CollectibleState.explored));
  }

  @override
  Widget build(BuildContext context) {
    final states = watchX((CollectiblesLogic o) => o.statesById);
    List<CollectibleData> collectibles = collectiblesLogic.forWonder(data.type);
    return Center(
      child: SizedBox(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Title
            Text(
              data.title.toUpperCase(),
              textAlign: TextAlign.left,
              style: $styles.text.title1.copyWith(color: $styles.colors.offWhite),
            ),
            Gap($styles.insets.md),

            /// Images
            Expanded(
              child: SeparatedRow(
                  separatorBuilder: () => Gap($styles.insets.sm),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...collectibles.map((e) {
                      int state = states[e.id] ?? CollectibleState.lost;
                      return Flexible(
                        child: _CollectibleImage(
                          collectible: e,
                          state: state,
                          onPressed: (c) => _showDetails(context, c),
                          heroTag: e.id == fromId ? 'collectible_image_$fromId' : null,
                        ),
                      );
                    })
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
