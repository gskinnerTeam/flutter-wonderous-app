import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/logic/data/wonder_data.dart';

class CollectionScreen extends StatelessWidget {
  CollectionScreen({String? fromId, Key? key}) : super(key: key) {
    // todo: scroll to the fromCollectible if possible
    // https://stackoverflow.com/questions/49153087/flutter-scrolling-to-a-widget-in-listview
    fromCollectible = collectibles[0];
  }

  late final CollectibleData? fromCollectible;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.greyStrong,
      child: Stack(children: [
        Positioned.fill(
          child: SafeArea(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              _buildTitleRow(context),
              _buildNewItemsRow(context),
              _buildList(context),
            ]),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildFooter(context),
        )
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
          'COLLECTION',
          textAlign: TextAlign.center,
          style: context.textStyles.h3.copyWith(color: context.colors.offWhite),
        ),
      ),
      Container(width: 64),
    ]);
  }

  Widget _buildNewItemsRow(BuildContext context) {
    return Container(
      color: context.colors.black,
      padding: EdgeInsets.symmetric(vertical: context.insets.xs),
      child: Text(
        '1 new item to explore',
        textAlign: TextAlign.center,
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
        style: context.textStyles.body2.copyWith(color: context.colors.accent1),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    List<WonderData> wonders = wondersLogic.all;
    List<Widget> children = [];
    for (int i = 0; i < wonders.length; i++) {
      WonderData data = wonders[i];
      children.add(_buildCategoryTitle(context, data));
      children.add(Gap(context.insets.md));
      children.add(_buildCollectibleRow(context, data.type));
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

  Widget _buildCollectibleRow(BuildContext context, WonderType wonder) {
    final double height = context.insets.lg * 6;
    List<CollectibleData> list = collectibles.where((o) => o.wonder == wonder).toList(growable: false);
    if (list.isEmpty) return Container(height: height, color: context.colors.black);

    List<Widget> children = [];
    for (int i = 0; i < list.length; i++) {
      if (i > 0) children.add(Gap(context.insets.md));
      children.add(_buildCollectible(context, list[i], height));
    }

    return Row(children: children);
  }

  Widget _buildCollectible(BuildContext context, CollectibleData collectible, double height) {
    // todo: temporary:
    int state = rnd.getBool(0.67) ? 2 : 0;
    if (collectible.id == '701645') state = 1;
    // todo: add logic to look up collectible state (hidden, found, explored)
    Widget content = state == CollectedState.hidden
        ? _buildHiddenCollectible(context, collectible)
        : _buildFoundCollectible(context, collectible, state);

    return Flexible(child: SizedBox(height: height, child: content));
  }

  Widget _buildHiddenCollectible(BuildContext context, CollectibleData collectible) {
    final Color fadedGrey = context.colors.greyMedium.withOpacity(0.33);
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
          child: Image(
            image: collectible.icon,
            color: fadedGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildFoundCollectible(BuildContext context, CollectibleData collectible, int state) {
    // todo: add tap interaction.
    final bool isNew = state == CollectedState.found;
    Widget content = Container(
      decoration: BoxDecoration(
        color: context.colors.black,
        border: isNew ? Border.all(color: context.colors.accent1, width: 3) : null,
        boxShadow:
            !isNew ? null : [BoxShadow(color: context.colors.accent1.withOpacity(0.6), blurRadius: context.insets.sm)],
      ),
      child: CachedNetworkImage(
        alignment: Alignment.center,
        imageUrl: collectible.imageUrl,
        fit: BoxFit.cover,
      ),
    );
    if (collectible == fromCollectible) content = Hero(tag: 'collectible_image', child: content);
    return GestureDetector(
      onTap: () => context.push(ScreenPaths.artifact(collectible.artifactId)),
      child: content,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.insets.md, vertical: context.insets.sm),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          context.colors.greyStrong.withOpacity(0),
          context.colors.greyStrong,
        ],
        stops: const [0, 0.5],
      )),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gap(context.insets.xl),
            _buildProgressRow(context, 16, 24),
            Gap(context.insets.sm),
            _buildProgressBar(context, 16, 24),
            Gap(context.insets.sm),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressRow(BuildContext context, int found, int total) {
    return Row(children: [
      Text(
        '${(found / total * 100).round()}% Discovered',
        style: context.textStyles.body1.copyWith(color: context.colors.accent1),
      ),
      Spacer(),
      Text(
        '$found of $total',
        style: context.textStyles.body1.copyWith(color: context.colors.offWhite),
      )
    ]);
  }

  Widget _buildProgressBar(BuildContext context, int found, int total) {
    return Container(
      height: context.insets.xs,
      decoration: BoxDecoration(
        color: context.colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.accent1,
          borderRadius: BorderRadius.circular(1000),
        ),
      ).fx().fade(duration: 1500.ms, curve: Curves.easeOutExpo).build((_, m, child) =>
          FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: m * found / total, child: child)),
    );
  }
}
