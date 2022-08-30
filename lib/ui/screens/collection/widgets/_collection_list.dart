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
    List<Widget> children = [];
    for (int i = 0; i < wonders.length; i++) {
      WonderData data = wonders[i];
      children.add(_buildCategoryTitle(context, data, data.type == scrollWonder ? scrollKey : null));
      children.add(Gap($styles.insets.md));
      children.add(_buildCollectibleRow(context, data.type, states));
      children.add(Gap($styles.insets.xl));
    }

    children.add(_buildResetBtn(context));

    return Flexible(
      child: RepaintBoundary(
        child: ScrollDecorator.shadow(
          builder: (controller) => SingleChildScrollView(
            controller: controller,
            padding: EdgeInsets.all($styles.insets.md).copyWith(bottom: $styles.insets.offset * 2.5),
            child: Column(
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTitle(BuildContext context, WonderData data, Key? key) {
    return Text(
      data.title.toUpperCase(),
      textAlign: TextAlign.left,
      key: key,
      style: $styles.text.title1.copyWith(color: $styles.colors.offWhite),
    );
  }

  Widget _buildCollectibleRow(BuildContext context, WonderType wonder, Map<String, int> states) {
    final double height = $styles.insets.lg * 6;
    List<CollectibleData> list = collectiblesLogic.forWonder(wonder);
    if (list.isEmpty) return Container(height: height, color: $styles.colors.black);

    List<Widget> children = [];
    for (int i = 0; i < list.length; i++) {
      if (i > 0) children.add(Gap($styles.insets.md));
      CollectibleData collectible = list[i];
      int state = states[collectible.id] ?? CollectibleState.lost;
      children.add(Flexible(
        child: _CollectionTile(
          collectible: collectible,
          state: state,
          onPressed: onPressed,
          heroTag: collectible.id == fromId ? 'collectible_image_$fromId' : null,
        ),
      ));
    }
    return SizedBox(height: height, child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: children));
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
