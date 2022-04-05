import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';

class ArtifactSearchTextField extends StatelessWidget {
  ArtifactSearchTextField({Key? key, required this.onUpdate}) : super(key: key);
  final void Function(String) onUpdate;

  final TextEditingController _textController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    Color colorSearchBox = context.colors.text;
    Color colorCaption = context.colors.caption;

    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }

        // Start with a list of results from a prebaked list of strings. TODO: Make this more thorough, like a JSON based on Wonder type.
        List<String> results = _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        }).toList();

        // Use titles of artifacts that have already been loaded.
        List<ArtifactData> allArtifacts = search.allLoadedArtifacts;
        if (allArtifacts.isNotEmpty) {
          List<ArtifactData?> artifacts = allArtifacts.where((ArtifactData? data) {
            return data?.title.toLowerCase().contains(textEditingValue.text.toLowerCase()) ?? false;
          }).toList();
          for (var artifact in artifacts) {
            if (artifact != null) {
              results.add(artifact.title);
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
      onSelected: onUpdate,
      /* TODO: Uncomment if we want to style the dropdown.
      optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> results) {
        return ListView(
          children: results.map((String result) {
            return GestureDetector(
              onTap: () {
                onSelected(result);
              },
              child: ListTile(
                title: Text(result),
              ),
            );
          }).toList(),
        );
      },
      */
      fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) {
        // Physical text field, for styling and looking good.
        return TextField(
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
              hintStyle: TextStyle(color: colorCaption.withAlpha(125)),
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
    );
  }
}
