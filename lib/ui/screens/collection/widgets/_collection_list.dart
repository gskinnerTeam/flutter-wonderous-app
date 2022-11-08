part of '../collection_screen.dart';

@immutable
class _CollectionList extends StatelessWidget {
  const _CollectionList({
    Key? key,
    required this.states,
    this.onReset,
    this.fromId,
    this.scrollKey,
  }) : super(key: key);

  final Map<String, int> states;
  final VoidCallback? onReset;
  final Key? scrollKey;
  final String? fromId;

  WonderType? get scrollTargetWonder {
    String? id = fromId;
    if (states[id] != CollectibleState.discovered) {
      id = states.keys.firstWhereOrNull((id) => states[id] == CollectibleState.discovered);
    }
    return collectiblesLogic.fromId(id)?.wonder;
  }

  @override
  Widget build(BuildContext context) {
    List<WonderData> wonders = wondersLogic.all;
    bool vtMode = context.isLandscape == false;
    final scrollWonder = scrollTargetWonder;
    // Create list of collections that is shared by both hz and vt layouts
    List<Widget> collections = [
      ...wonders.map((d) {
        return _CollectionListCard(
          key: d.type == scrollWonder ? scrollKey : null,
          height: vtMode ? 300 : 400,
          width: vtMode ? null : 600,
          fromId: fromId,
          states: states,
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
