import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/screens/search/search_screen_header.dart';

/// PageView sandwiched between Foreground and Background layers
/// arranged in a parallax style
class SearchScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  SearchScreen({Key? key, required this.type}) : super(key: key);
  final WonderType type;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with GetItStateMixin {
  //final _pageController = PageController(viewportFraction: 1);
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  // TODO: Get prebuilt list of common autocomplete terms.
  List<String> _kOptions = [
    'hat',
    'coin',
    'urn',
    'vase',
    'statue',
    'painting',
    'sculpture',
    'graffiti',
    'art',
    'clothing',
    'tool'
  ];

  List<ArtifactData?> _searchResultsAll = [];
  bool _isLoading = false;
  bool _isEmpty = false;

  @override
  void initState() {
    // Search test.
    super.initState();
    _scrollController.addListener(() {});
  }

  void searchForStuff(String? query) async {
    query = query ?? _textController.text;
    if (_isLoading) {
      return;
    }

    // Reset the view state; show that it's loading and prevent subsequent calls until complete.
    setState(() {
      _isEmpty = false;
      _isLoading = true;
    });

    // Get all search results, with a limit.
    _searchResultsAll = await search.searchForArtifacts(query, count: 1000);

    // Load complete. Show results.
    setState(() {
      _isLoading = false;
      _isEmpty = _searchResultsAll.isEmpty;
    });
  }

  void handleImagePressed(ArtifactData artifact) {
    // User clicked image. Open Artifact Details view
    context.push(ScreenPaths.artifact(artifact.objectId.toString(), widget.type));
  }

  @override
  Widget build(BuildContext context) {
    String resultsText = '';
    if (_isLoading) {
      resultsText = 'Loading, one sec...';
    } else if (_isEmpty) {
      resultsText = 'Sorry, no results found';
    } else if (_searchResultsAll.isNotEmpty) {
      resultsText = '${_searchResultsAll.length} results found';
    }

    Color colorBody = context.colors.body;
    Color colorSearchBox = context.colors.text;
    Color colorCaption = context.colors.caption;

    /// Collect children for the various layers
    return Flex(
      mainAxisSize: MainAxisSize.max,
      direction: Axis.vertical,
      children: [
        // Header
        SafeArea(
          child: SearchScreenHeader(widget.type, 'Browse Artifacts'),
        ),

        // Content
        Expanded(
          child: Container(
            color: context.colors.bg,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.insets.md, vertical: context.insets.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search box
                  // TODO: Look into an autocompleting search box - may need to use department names and a hard-coded list of common terms.

                  Autocomplete(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }

                      // Start with a list of results from a prebaked list of strings. TODO: Make this more thorough, like a JSON based on Wonder type.
                      List<String> results = _kOptions.where((String option) {
                        return option.contains(textEditingValue.text.toLowerCase());
                      }).toList();

                      // Use titles of artifacts that have already been loaded.
                      List<ArtifactData> allArtifacts = search.getAllArtifacts();
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
                    onSelected: searchForStuff,
                    fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) {
                      return TextField(
                        controller: _textController,
                        onSubmitted: (query) {
                          onFieldSubmitted();
                        },
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
                  ),

                  // Results feedback
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: context.insets.sm),
                    child: Text(
                      resultsText,
                      style: context.textStyles.body.copyWith(color: colorBody),
                    ),
                  ),

                  // Artifacts grid
                  Expanded(
                    child: CustomScrollView(
                      controller: _scrollController,
                      cacheExtent: 2000,
                      slivers: [
                        SliverToBoxAdapter(
                          child: MasonryGridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: context.insets.sm,
                            mainAxisSpacing: context.insets.sm,
                            itemCount: _searchResultsAll.length,
                            clipBehavior: Clip.antiAlias,
                            itemBuilder: (BuildContext context, int index) {
                              var data = _searchResultsAll[index];
                              return GestureDetector(
                                onTap: () => handleImagePressed(data!),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(context.insets.xs),
                                  child: CachedNetworkImage(
                                      imageUrl: data!.image,
                                      placeholder: (BuildContext context, String url) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(context.corners.md)),
                                              border: Border.all(color: context.colors.accent2, width: 3)),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Center(
                                              heightFactor: 1,
                                              child: AppLoader(),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
