part of '../artifact_search_screen.dart';

// TODO: GDS: evaluate search suggestions. Possibly generate alongside SearchData

/// Autopopulating textfield used for searching for Artifacts by name.
class _SearchInput extends StatelessWidget {
  const _SearchInput({Key? key, required this.onSubmit, required this.wonder}) : super(key: key);
  final void Function(String) onSubmit;
  final WonderData wonder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => Autocomplete<String>(
        displayStringForOption: (data) => data,
        onSelected: onSubmit,
        optionsBuilder: _getSuggestions,
        optionsViewBuilder: (context, onSelected, results) =>
            _buildSuggestionsView(context, onSelected, results, constraints),
        fieldViewBuilder: _buildInput,
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
    return TopLeft(
      child: Container(
        margin: EdgeInsets.only(top: context.insets.xxs),
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: context.colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(context.insets.xs),
          decoration: BoxDecoration(
            color: context.colors.offWhite.withOpacity(0.9),
            borderRadius: BorderRadius.circular(context.insets.xs),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 200),
            child: ListView(
              padding: EdgeInsets.all(context.insets.xs),
              shrinkWrap: true,
              children: results.map((str) => _buildSuggestion(context, str, () => onSelected(str))).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestion(BuildContext context, String suggestion, VoidCallback onPressed) {
    return AppBtn.basic(
      semanticLabel: suggestion,
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all(context.insets.xs),
        child: CenterLeft(
          child: Text(
            suggestion,
            overflow: TextOverflow.ellipsis,
            textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
            style: context.textStyles.bodySmall.copyWith(color: context.colors.greyStrong),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(BuildContext context, TextEditingController textController, FocusNode focusNode, _) {
    Color captionColor = context.colors.caption;
    return Container(
      height: context.insets.xl,
      decoration: BoxDecoration(
        color: context.colors.offWhite,
        borderRadius: BorderRadius.circular(context.insets.xs),
      ),
      child: Row(children: [
        Gap(context.insets.xs * 1.5),
        Icon(Icons.search, color: context.colors.caption),
        Expanded(
          child: TextField(
            onSubmitted: onSubmit,
            controller: textController,
            focusNode: focusNode,
            style: TextStyle(color: captionColor),
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(context.insets.xs),
              labelStyle: TextStyle(color: captionColor),
              hintStyle: TextStyle(color: captionColor.withOpacity(0.5)),
              prefixStyle: TextStyle(color: captionColor),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              hintText: 'Search (ex. type or material)',
            ),
          ),
        ),
        Gap(context.insets.xs),
        ValueListenableBuilder(
          valueListenable: textController,
          builder: (_, value, __) => Visibility(
            visible: textController.value.text.isNotEmpty,
            child: Padding(
              padding: EdgeInsets.only(right: context.insets.xs),
              child: CircleIconBtn(
                bgColor: context.colors.caption,
                color: context.colors.white,
                icon: Icons.clear,
                semanticLabel: 'clear search',
                size: context.insets.lg,
                iconSize: context.insets.sm,
                onPressed: () {
                  textController.clear();
                  onSubmit('');
                },
              ),
            ),
          ),
        )
      ]),
    );
  }
}
