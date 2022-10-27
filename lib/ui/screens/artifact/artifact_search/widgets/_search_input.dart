part of '../artifact_search_screen.dart';

/// Autopopulating textfield used for searching for Artifacts by name.
class _SearchInput extends StatelessWidget {
  const _SearchInput({Key? key, required this.onSubmit, required this.wonder}) : super(key: key);
  final void Function(String) onSubmit;
  final WonderData wonder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => Center(
        child: Autocomplete<String>(
          displayStringForOption: (data) => data,
          onSelected: onSubmit,
          optionsBuilder: _getSuggestions,
          optionsViewBuilder: (context, onSelected, results) =>
              _buildSuggestionsView(context, onSelected, results, constraints),
          fieldViewBuilder: _buildInput,
        ),
      ),
    );
  }

  Iterable<String> _getSuggestions(TextEditingValue textEditingValue) {
    if (textEditingValue.text == '') return wonder.searchSuggestions.getRange(0, 10);

    return wonder.searchSuggestions.where((str) {
      return str.startsWith(textEditingValue.text.toLowerCase());
    }).toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  }

  Widget _buildSuggestionsView(BuildContext context, onSelected, Iterable<String> results, BoxConstraints constraints) {
    List<Widget> items = results.map((str) => _buildSuggestion(context, str, () => onSelected(str))).toList();
    items.insert(0, _buildSuggestionTitle(context));

    return TopLeft(
      child: Container(
        margin: EdgeInsets.only(top: $styles.insets.xxs),
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: $styles.colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all($styles.insets.xs),
          decoration: BoxDecoration(
            color: $styles.colors.offWhite.withOpacity(0.92),
            borderRadius: BorderRadius.circular($styles.insets.xs),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 200),
            child: ListView(
              padding: EdgeInsets.all($styles.insets.xs),
              shrinkWrap: true,
              children: items,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.all($styles.insets.xs).copyWith(top: 0),
      margin: EdgeInsets.only(bottom: $styles.insets.xxs),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: $styles.colors.greyStrong.withOpacity(0.1)))),
      child: CenterLeft(
        child: Text(
          $strings.searchInputTitleSuggestions.toUpperCase(),
          overflow: TextOverflow.ellipsis,
          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
          style: $styles.text.title2.copyWith(color: $styles.colors.black),
        ),
      ),
    );
  }

  Widget _buildSuggestion(BuildContext context, String suggestion, VoidCallback onPressed) {
    return AppBtn.basic(
      semanticLabel: suggestion,
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all($styles.insets.xs),
        child: CenterLeft(
          child: Text(
            suggestion,
            overflow: TextOverflow.ellipsis,
            textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
            style: $styles.text.bodySmall.copyWith(color: $styles.colors.greyStrong),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(BuildContext context, TextEditingController textController, FocusNode focusNode, _) {
    Color captionColor = $styles.colors.caption;
    return Container(
      height: $styles.insets.xl,
      decoration: BoxDecoration(
        color: $styles.colors.offWhite,
        borderRadius: BorderRadius.circular($styles.insets.xs),
      ),
      child: Row(
        children: [
          Gap($styles.insets.xs * 1.5),
          Icon(Icons.search, color: $styles.colors.caption),
          Expanded(
            child: TextField(
              onSubmitted: onSubmit,
              controller: textController,
              focusNode: focusNode,
              style: TextStyle(color: captionColor),
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all($styles.insets.xs),
                labelStyle: TextStyle(color: captionColor),
                hintStyle: TextStyle(color: captionColor.withOpacity(0.5)),
                prefixStyle: TextStyle(color: captionColor),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                hintText: $strings.searchInputHintSearch,
              ),
            ),
          ),
          Gap($styles.insets.xs),
          ValueListenableBuilder(
            valueListenable: textController,
            builder: (_, value, __) => Visibility(
              visible: textController.value.text.isNotEmpty,
              child: Padding(
                padding: EdgeInsets.only(right: $styles.insets.xs),
                child: CircleIconBtn(
                  bgColor: $styles.colors.caption,
                  color: $styles.colors.white,
                  icon: AppIcons.close,
                  semanticLabel: $strings.searchInputSemanticClear,
                  size: $styles.insets.lg,
                  iconSize: $styles.insets.sm,
                  onPressed: () {
                    textController.clear();
                    onSubmit('');
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
