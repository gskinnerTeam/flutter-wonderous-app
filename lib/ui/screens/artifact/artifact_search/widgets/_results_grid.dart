part of '../artifact_search_screen.dart';

/// Staggered Masonry styled grid for displaying two columns of different aspect-ratio images.
class _ResultsGrid extends StatefulWidget {
  _ResultsGrid({Key? key, required this.searchResults, required this.onPressed}) : super(key: key);
  final void Function(SearchData) onPressed;
  final List<SearchData> searchResults;

  @override
  State<_ResultsGrid> createState() => _ResultsGridState();
}

class _ResultsGridState extends State<_ResultsGrid> {
  late ScrollController _controller;

  double _prevVel = -1;

  void _handleResultsScrolled() {
    // Hide the keyboard if the list is scrolled manually by the pointer, ignoring velocity based scroll changes like deceleration or over-scroll bounce
    // ignore: INVALID_USE_OF_PROTECTED_MEMBER, INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
    final vel = _controller.position.activity?.velocity;
    if (vel == 0 && _prevVel == 0) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    _prevVel = vel ?? _prevVel;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollDecorator.shadow(
      onInit: (controller) => controller.addListener(_handleResultsScrolled),
      builder: (controller) {
        _controller = controller;
        return CustomScrollView(
          controller: controller,
          scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          clipBehavior: Clip.hardEdge,
          slivers: [
            SliverToBoxAdapter(child: _buildLanguageMessage(context)),
            SliverPadding(
              padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset * 1.5),
              sliver: SliverMasonryGrid.count(
                crossAxisCount: (context.widthPx / 300).ceil(),
                mainAxisSpacing: $styles.insets.sm,
                crossAxisSpacing: $styles.insets.sm,
                childCount: widget.searchResults.length,
                itemBuilder: (context, index) =>
                    _ResultTile(onPressed: widget.onPressed, data: widget.searchResults[index]),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLanguageMessage(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: settingsLogic.hasDismissedSearchMessage,
      builder: (_, value, __) {
        if (localeLogic.isEnglish || value) return SizedBox();
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
