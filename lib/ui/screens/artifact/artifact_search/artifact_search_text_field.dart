import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/ui/common/cards/glass_card.dart';

/// Autopopulating textfield used for searching for Artifacts by name.
class ArtifactSearchTextField extends StatelessWidget {
  ArtifactSearchTextField({Key? key, required this.handleSearchSubmitted}) : super(key: key);
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
    Color colorSearchBox = context.colors.white;
    Color colorCaption = context.colors.caption;

    return LayoutBuilder(
      builder: (ctx, constraints) => Autocomplete(
        optionsBuilder: (TextEditingValue textEditingValue) {
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
        },
        displayStringForOption: (String data) => data,
        onSelected: handleSearchSubmitted,
        optionsViewBuilder:
            (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> results) {
          return TopLeft(
            child: Padding(
              padding: EdgeInsets.only(top: context.insets.xs),
              child: Container(
                width: constraints.maxWidth,
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: context.colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 4)),
                  ],
                ),
                child: GlassCard(
                  padding: EdgeInsets.all(context.insets.sm),
                  color: context.colors.white.withOpacity(0.75),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Search Suggestions',
                          style: context.textStyles.tab.copyWith(color: context.colors.greyStrong)),
                      Gap(context.insets.sm),
                      Expanded(
                        child: SizedBox(
                          width: constraints.biggest.width - context.insets.sm * 2,
                          height: constraints.maxHeight / 2,
                          child: ListView(
                            children: results.map((String result) {
                              return GestureDetector(
                                onTap: () {
                                  onSelected(result);
                                },
                                child: Text(
                                  StringUtils.truncateWithEllipsis(43, result),
                                  style: context.textStyles.body4.copyWith(color: context.colors.greyStrong),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) {
          // Physical text field, for styling and looking good.
          return TextField(
            autofocus: true,
            controller: textController,
            onSubmitted: (query) => onFieldSubmitted(),
            focusNode: focusNode,
            style: TextStyle(color: colorCaption),
            decoration: InputDecoration(
                icon: Icon(Icons.search, color: colorCaption),
                filled: true,
                fillColor: colorSearchBox,
                iconColor: colorCaption,
                labelStyle: TextStyle(color: colorCaption),
                hintStyle: TextStyle(color: colorCaption.withOpacity(0.5)),
                prefixStyle: TextStyle(color: colorCaption),
                focusColor: colorCaption,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorSearchBox),
                    borderRadius: BorderRadius.circular(context.corners.md)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorSearchBox),
                  borderRadius: BorderRadius.circular(context.corners.md),
                ),
                hintText: 'Search type or material'),
          );
        },
      ),
    );
  }
}
