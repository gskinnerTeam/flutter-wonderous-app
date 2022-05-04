part of '../artifact_search_screen.dart';

/// Staggered Masonry styled grid for displaying two columns of different aspect-ratio images.
class _ResultsGrid extends StatelessWidget {
  const _ResultsGrid({Key? key, required this.searchResults, required this.onPressed}) : super(key: key);
  final void Function(SearchData) onPressed;
  final List<SearchData> searchResults;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ScrollDecorator.shadow(
        color: context.colors.black.withOpacity(0.25),
        builder: (controller) => MasonryGridView.count(
          shrinkWrap: true,
          addAutomaticKeepAlives: false,
          padding: EdgeInsets.symmetric(vertical: context.insets.xxs, horizontal: context.insets.sm),
          controller: controller,
          crossAxisCount: 2,
          mainAxisSpacing: context.insets.sm,
          crossAxisSpacing: context.insets.sm,
          itemCount: searchResults.length,
          clipBehavior: Clip.hardEdge,
          itemBuilder: (context, index) => _ResultTile(onPressed: onPressed, data: searchResults[index]),
        ),
      ),
    );
  }
}
