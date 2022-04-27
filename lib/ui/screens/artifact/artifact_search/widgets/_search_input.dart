part of '../artifact_search_screen.dart';

/// Autopopulating textfield used for searching for Artifacts by name.
class _SearchInput extends StatelessWidget {
  _SearchInput({Key? key, required this.handleSearchSubmitted}) : super(key: key);
  final void Function(String) handleSearchSubmitted;

  // TODO: Get prebuilt list of common autocomplete terms. Might be artifact-specific.
  final List<String> _kOptions = [
    'hat',
    'coin',
    'urn',
    'jar',
    'bust',
    'figurine',
    'vase',
    'toy',
    'statue',
    'painting',
    'sculpture',
    'graffiti',
    'art',
    'clothing',
    'tool'
  ];

  final List<String> _materialFilteringTerms = [
    'Axes',
    'Arrowheads',
    'Belts',
    'Blades',
    'Books',
    'Bowls',
    'Busts',
    'Calligraphy',
    'Chisels',
    'Costume',
    'Cups',
    'Daggers',
    'Dishes',
    'Earrings',
    'Engraving',
    'Figures',
    'Flute',
    'Furniture',
    'Glass',
    'Jars',
    'Jewelry',
    'Lamps',
    'Masks',
    'Metalwork',
    'Musical Instruments',
    'Ornaments',
    'Paintings',
    'Pendants',
    'Plate',
    'Pottery',
    'Reliefs',
    'Rings',
    'Sarcophagi',
    'Scepters',
    'Statues',
    'Swords',
    'Textiles',
    'Vases',
    'Vessels',
    'Whistles',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.insets.sm),
      child: LayoutBuilder(
        builder: (ctx, constraints) => Autocomplete(
          displayStringForOption: (String data) => data,
          onSelected: handleSearchSubmitted,
          optionsBuilder: _getSuggestions,
          optionsViewBuilder: (context, onSelected, Iterable<String> results) =>
              _buildSuggestionsView(context, onSelected, results, constraints),
          fieldViewBuilder: _buildInput,
        ),
      ),
    );
  }

  Iterable<String> _getSuggestions(TextEditingValue textEditingValue) {
    if (textEditingValue.text == '') {
      return const Iterable<String>.empty();
    }

    // Start with a list of results from a prebaked list of strings. TODO: Make this more thorough, like a JSON based on Wonder type.
    List<String> results = _materialFilteringTerms.where((String option) {
      return option.toLowerCase().startsWith(textEditingValue.text.toLowerCase());
    }).toList();

    // Use titles of artifacts that have already been loaded.
    List<ArtifactData> allArtifacts = searchLogic.allLoadedArtifacts;
    if (allArtifacts.isNotEmpty) {
      // Get all artifacts that follow the same search convention.
      List<ArtifactData?> artifacts = allArtifacts.where((ArtifactData? data) {
        return data?.title.toLowerCase().startsWith(textEditingValue.text.toLowerCase()) ?? false;
      }).toList();

      // Only use titles if there are less than 10 results.
      if (artifacts.length <= 10) {
        for (var artifact in artifacts) {
          if (artifact != null) {
            results.add(artifact.title);
          }
        }
      }
    }

    // Sort everything in alphabetical order.
    results.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });

    // Return the autocomplete results.
    return results;
  }

  Widget _buildSuggestionsView(BuildContext context, onSelected, Iterable<String> results, BoxConstraints constraints) {
    return TopLeft(
      child: Container(
        margin: EdgeInsets.only(top: context.insets.xs),
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: context.colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: GlassCard(
          padding: EdgeInsets.all(context.insets.xxs),
          color: context.colors.white.withOpacity(0.75),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 120),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: results.map((str) => _buildSuggestion(context, str, () => onSelected(str))).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestion(BuildContext context, String suggestion, VoidCallback onPressed) {
    return BasicBtn(
      semanticLabel: suggestion,
      onPressed: onPressed,
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.insets.xxs, horizontal: context.insets.xs),
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
        color: context.colors.white,
        borderRadius: BorderRadius.circular(context.insets.xs),
      ),
      child: Row(children: [
        Gap(context.insets.xs * 1.5),
        Icon(Icons.search, color: context.colors.caption),
        Expanded(
          child: TextField(
            onSubmitted: handleSearchSubmitted,
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
              hintText: 'Search type or material',
            ),
          ),
        ),
      ]),
    );
  }
}
