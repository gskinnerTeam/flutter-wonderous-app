part of '../collection_screen.dart';

@immutable
class _CollectionList extends StatelessWidget with GetItMixin {
  _CollectionList({
    Key? key,
    this.onReset,
    required this.fromId,
    this.scrollKey,
  }) : super(key: key);

  final VoidCallback? onReset;
  final Key? scrollKey;
  final String fromId;

  WonderType? get scrollTargetWonder {
    CollectibleData? item;
    if (fromId.isEmpty) {
      item = collectiblesLogic.getFirstDiscoveredOrNull();
    } else {
      item = collectiblesLogic.fromId(fromId);
    }
    return item?.wonder;
  }

  @override
  Widget build(BuildContext context) {
    watchX((CollectiblesLogic o) => o.statesById);
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
          data: d,
        );
      }).toList()
    ];
    // Scroll view adapts to scroll vertically or horizontally
    return SingleChildScrollView(
      scrollDirection: vtMode ? Axis.vertical : Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.all($styles.insets.lg),
        child: SeparatedFlex(
          direction: vtMode ? Axis.vertical : Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          separatorBuilder: () => Gap($styles.insets.lg),
          children: [
            ...collections,
            Gap($styles.insets.sm),
            _buildResetBtn(context),
          ],
        ),
      ),
    );
  }

  Widget _buildResetBtn(BuildContext context) {
    Widget btn = AppBtn.from(
      onPressed: onReset ?? () {},
      text: $strings.collectionButtonReset,
      isSecondary: true,
      expand: true,
    );
    return AnimatedOpacity(opacity: onReset == null ? 0.25 : 1, duration: $styles.times.fast, child: btn);
  }
}
