part of '../collection_screen.dart';

@immutable
class _CollectionList extends StatelessWidget {
  const _CollectionList({
    Key? key,
    required this.states,
    required this.onPressed,
    this.onReset,
    this.fromId,
    this.scrollWonder,
    this.scrollKey,
  }) : super(key: key);

  final Map<String, int> states;
  final ValueSetter<CollectibleData> onPressed;
  final VoidCallback? onReset;
  final Key? scrollKey;
  final WonderType? scrollWonder;
  final String? fromId;

  @override
  Widget build(BuildContext context) {
    List<WonderData> wonders = wondersLogic.all;
    bool vtMode = context.isLandscape == false;
    // Create list of collections that is shared by both hz and vt layouts
    List<Widget> collections = [
      ...wonders.map((d) {
        return _buildSingleCollection(
          context,
          height: vtMode ? 300 : 400,
          width: vtMode ? null : 600,
          data: d,
        );
      }).toList()
    ];
    // Scroll view adapts to scroll vertically or horizontally
    return SingleChildScrollView(
      scrollDirection: vtMode ? Axis.vertical : Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.all($styles.insets.lg),
        child: vtMode
            ? SeparatedColumn(
                mainAxisSize: MainAxisSize.min,
                separatorBuilder: () => Gap($styles.insets.lg),
                children: collections,
              )
            : SeparatedRow(
                separatorBuilder: () => Gap($styles.insets.xl * 2),
                mainAxisSize: MainAxisSize.min,
                children: collections,
              ),
      ),
    );
  }

  Widget _buildSingleCollection(BuildContext context, {double? width, double? height, required WonderData data}) {
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
              key: data.type == scrollWonder ? scrollKey : null,
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
                        child: _CollectionTile(
                          collectible: e,
                          state: state,
                          onPressed: onPressed,
                          heroTag: e.id == fromId ? 'collectible_image_$fromId' : null,
                        ),
                      );
                    }).toList()
                  ]),
            )
          ],
        ),
      ),
    );
  }

  // TODO: Restore reset functionality somehow
  // Widget _buildResetBtn(BuildContext context) {
  //   Widget btn = AppBtn.from(
  //     onPressed: onReset ?? () {},
  //     text: $strings.collectionButtonReset,
  //     isSecondary: true,
  //     expand: true,
  //   );
  //   return AnimatedOpacity(opacity: onReset == null ? 0.25 : 1, duration: $styles.times.fast, child: btn);
  // }
}
