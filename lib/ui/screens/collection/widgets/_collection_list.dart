part of '../collection_screen.dart';

@immutable
class _CollectionList extends StatelessWidget {
  const _CollectionList({
    Key? key,
    required this.states,
    required this.onPressed,
    this.fromId,
    this.scrollWonder,
    this.scrollKey,
  }) : super(key: key);

  final Map<String, int> states;
  final ValueSetter<CollectibleData> onPressed;
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
      children.add(Gap(context.insets.md));
      children.add(_buildCollectibleRow(context, data.type, states));
      children.add(Gap(context.insets.xl));
    }

    return Flexible(
      child: RepaintBoundary(
        child: ScrollDecorator.shadow(
          builder: (controller) => ListView(
            controller: controller,
            padding: EdgeInsets.all(context.insets.md).copyWith(bottom: context.insets.offset * 2),
            children: children,
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
      style: context.textStyles.title1.copyWith(color: context.colors.offWhite),
    );
  }

  Widget _buildCollectibleRow(BuildContext context, WonderType wonder, Map<String, int> states) {
    final double height = context.insets.lg * 6;
    List<CollectibleData> list = collectiblesLogic.forWonder(wonder);
    if (list.isEmpty) return Container(height: height, color: context.colors.black);

    List<Widget> children = [];
    for (int i = 0; i < list.length; i++) {
      if (i > 0) children.add(Gap(context.insets.md));
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
}
