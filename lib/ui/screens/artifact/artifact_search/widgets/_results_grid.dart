part of '../artifact_search_screen.dart';

/// Staggered Masonry styled grid for displaying two columns of different aspect-ratio images.
class _ResultsGrid extends StatelessWidget {
  const _ResultsGrid({Key? key, required this.searchResults, required this.onPressed}) : super(key: key);
  final void Function(SearchData) onPressed;
  final List<SearchData> searchResults;

  @override
  Widget build(BuildContext context) {
    return ScrollDecorator.shadow(
      builder: (controller) => CustomScrollView(
        controller: controller,
        scrollBehavior: const ScrollBehavior().copyWith(scrollbars: false),
        clipBehavior: Clip.hardEdge,
        slivers: [
          SliverToBoxAdapter(child: _buildLanguageMessage(context)),
          SliverPadding(
            padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset * 1.5),
            sliver: SliverMasonryGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: $styles.insets.sm,
              crossAxisSpacing: $styles.insets.sm,
              childCount: searchResults.length,
              itemBuilder: (context, index) => _ResultTile(onPressed: onPressed, data: searchResults[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageMessage(BuildContext context) {
    bool isEnglish = localeLogic.strings.localeName == 'en';
    return ValueListenableBuilder<bool>(
      valueListenable: settingsLogic.hasDismissedSearchMessage,
      builder: (_, value, __) {
        if (isEnglish || value) return SizedBox();
        return AppBtn.basic(
          onPressed: () => settingsLogic.hasDismissedSearchMessage.value = true,
          semanticLabel: $strings.resultsSemanticDismiss,
          child: Container(
            color: $styles.colors.offWhite.withOpacity(0.1),
            padding: EdgeInsets.all($styles.insets.sm),
            child: Row(
              children: [
                Flexible(
                  child: Text($strings.resultsPopupEnglishContent),
                ),
                Icon(
                  Icons.close,
                  size: $styles.insets.md,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
