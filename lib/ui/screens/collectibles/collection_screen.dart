import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/collectibles_logic.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/logic/data/wonder_data.dart';

part 'widgets/_progress_bar.dart';
part 'widgets/_collection_tile.dart';

class CollectionScreen extends StatelessWidget with GetItMixin {
  CollectionScreen({String? fromId, Key? key}) : super(key: key) {
    // todo: scroll to the fromCollectible if possible
    // https://stackoverflow.com/questions/49153087/flutter-scrolling-to-a-widget-in-listview
    fromCollectible = collectibles.firstWhere((o) => o.id == fromId);
  }

  late final CollectibleData? fromCollectible;

  @override
  Widget build(BuildContext context) {
    final states = watchX((CollectiblesLogic o) => o.states);
    int discovered = 0, explored = 0, total = collectibles.length;
    states.forEach((_, state) {
      if (state == CollectibleState.discovered) discovered++;
      if (state == CollectibleState.explored) explored++;
    });
    return ColoredBox(
      color: context.colors.greyStrong,
      child: Stack(children: [
        Positioned.fill(
          child: SafeArea(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              _buildTitleRow(context),
              _buildNewItemsRow(context, discovered),
              _buildList(context, states),
            ]),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildFooter(context, discovered + explored, total),
        ),
      ]),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(children: [
      Container(
        width: 64,
        height: 80,
        alignment: Alignment.centerRight,
        child: CircleIconBtn(
          icon: Icons.arrow_back,
          onPressed: () => context.pop(),
        ),
      ),
      Flexible(
        fit: FlexFit.tight,
        child: Text(
          'Collection'.toUpperCase(),
          textAlign: TextAlign.center,
          style: context.textStyles.h3.copyWith(color: context.colors.offWhite),
        ),
      ),
      Container(width: 64),
    ]);
  }

  Widget _buildNewItemsRow(BuildContext context, int count) {
    if (count == 0) return SizedBox.shrink();
    return Container(
      color: context.colors.black,
      padding: EdgeInsets.symmetric(vertical: context.insets.xs),
      child: Text(
        '$count new item${count == 0 ? '' : 's'} to explore',
        textAlign: TextAlign.center,
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
        style: context.textStyles.body2.copyWith(color: context.colors.accent1),
      ),
    );
  }

  Widget _buildList(BuildContext context, Map<String, int> states) {
    List<WonderData> wonders = wondersLogic.all;
    List<Widget> children = [];
    for (int i = 0; i < wonders.length; i++) {
      WonderData data = wonders[i];
      children.add(_buildCategoryTitle(context, data));
      children.add(Gap(context.insets.md));
      children.add(_buildCollectibleRow(context, data.type, states));
      children.add(Gap(context.insets.xl));
    }
    children.add(Gap(context.insets.offset));

    return Flexible(
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(context.insets.md),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTitle(BuildContext context, WonderData data) {
    return Text(
      data.title.toUpperCase(),
      textAlign: TextAlign.left,
      style: context.textStyles.title1.copyWith(color: context.colors.offWhite),
    );
  }

  Widget _buildCollectibleRow(BuildContext context, WonderType wonder, Map<String, int> states) {
    final double height = context.insets.lg * 6;
    List<CollectibleData> list = collectibles.where((o) => o.wonder == wonder).toList(growable: false);
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
          onPressed: (o) => _showDetails(context, o),
          heroTag: collectible == fromCollectible ? 'collectible_image_${collectible.id}' : null,
        ),
      ));
    }
    return SizedBox(height: height, child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: children));
  }

  Widget _buildFooter(BuildContext context, int count, int total) {
    // This is broken into two, so that the gradient isn't clickable:
    return Column(children: [
      IgnorePointer(
        child: Container(
          height: context.insets.xl,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                context.colors.greyStrong.withOpacity(0),
                context.colors.greyStrong,
              ],
              stops: const [0, 1],
            ),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: context.insets.md, vertical: context.insets.sm),
        color: context.colors.greyStrong,
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProgressRow(context, count, total),
              Gap(context.insets.sm),
              _ProgressBar(count, total),
              Gap(context.insets.sm),
            ],
          ),
        ),
      )
    ]);
  }

  Widget _buildProgressRow(BuildContext context, int count, int total) {
    return Row(children: [
      Text(
        '${(count / total * 100).round()}% discovered',
        style: context.textStyles.body1.copyWith(color: context.colors.accent1),
      ),
      Spacer(),
      Text(
        '$count of $total',
        style: context.textStyles.body1.copyWith(color: context.colors.offWhite),
      )
    ]);
  }

  void _showDetails(BuildContext context, CollectibleData collectible) {
    context.push(ScreenPaths.artifact(collectible.artifactId));
    Future.delayed(300.ms).then((_) => collectiblesLogic.updateState(collectible.id, CollectibleState.explored));
  }
}
