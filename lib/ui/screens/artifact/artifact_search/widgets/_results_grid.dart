part of '../artifact_search_screen.dart';

/// Staggered Masonry styled grid for displaying two columns of different aspect-ratio images.
class _ResultsGrid extends StatelessWidget {
  const _ResultsGrid({Key? key, required this.scrollController, required this.searchResults, required this.onPressed})
      : super(key: key);
  final void Function(ArtifactData) onPressed;
  final ScrollController scrollController;
  final List<ArtifactData?> searchResults;

  @override
  Widget build(BuildContext context) {
    return ScrollDecorator.shadow(
      controller: scrollController,
      builder: (controller) => MasonryGridView.count(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: context.insets.xxs, horizontal: context.insets.sm),
        controller: controller,
        crossAxisCount: 2,
        cacheExtent: 2000,
        mainAxisSpacing: context.insets.sm,
        crossAxisSpacing: context.insets.sm,
        itemCount: searchResults.length,
        clipBehavior: Clip.antiAlias,
        itemBuilder: (context, index) => _ResultTile(onPressed: onPressed, data: searchResults[index]!),
      ),
    );
  }
}
