import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wonders/ui/common/controls/app_loader.dart';
import 'package:wonders/ui/screens/search/search_screen_header.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
  ScrollController scrollController = ScrollController();

  List<ArtifactData?> searchResultsAll = [];
  bool isLoading = false;
  bool isEmpty = false;
  bool isDisconnected = false;

  List<bool> imagesReady = [];

  @override
  void initState() {
    // Search test.
    super.initState();
    scrollController.addListener(() {});
  }

  void searchForStuff(String query) async {
    if (isLoading) {
      return;
    }

    // Reset the view state; show that it's loading and prevent subsequent calls until complete.
    setState(() {
      isEmpty = false;
      isDisconnected = false;
      isLoading = true;
    });

    // Get all search results, with a limit.
    searchResultsAll = await search.searchForArtifacts(query, count: 1000);

    // Load complete. Show results.
    setState(() {
      isLoading = false;
      isEmpty = searchResultsAll.isEmpty;
    });
  }

  void handleImagePressed(ArtifactData artifact) {
    // User clicked image. Open Artifact Details view
    context.push(ScreenPaths.artifact(artifact.objectId.toString(), widget.type));
  }

  @override
  Widget build(BuildContext context) {
    String resultsText = '';
    if (isLoading) {
      resultsText = 'Loading, one sec...';
    } else if (isEmpty) {
      resultsText = 'Sorry, no results found';
    } else if (isDisconnected) {
      resultsText = 'You appear to be offline';
    } else if (searchResultsAll.isNotEmpty) {
      resultsText = '${searchResultsAll.length} results found';
    }

    Color colorBody = context.colors.body;
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.insets.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search box
                // TODO: Look into an autocompleting search box - may need to use department names and a hard-coded list of common terms.
                TextField(
                  onSubmitted: searchForStuff,
                  style: TextStyle(color: colorCaption),
                  decoration: InputDecoration(
                      icon: Icon(Icons.search, color: colorCaption),
                      focusedBorder: InputBorder.none,
                      fillColor: context.colors.bg,
                      iconColor: colorCaption,
                      labelStyle: TextStyle(color: colorCaption),
                      hintStyle: TextStyle(color: colorCaption.withAlpha(125)),
                      prefixStyle: TextStyle(color: colorCaption),
                      focusColor: colorCaption,
                      hintText: 'Search type or material'),
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
                    controller: scrollController,
                    cacheExtent: 2000,
                    slivers: [
                      SliverToBoxAdapter(
                        child: MasonryGridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: context.insets.sm,
                          mainAxisSpacing: context.insets.sm,
                          itemCount: searchResultsAll.length,
                          clipBehavior: Clip.antiAlias,
                          itemBuilder: (BuildContext context, int index) {
                            var data = searchResultsAll[index];
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
      ],
    );
  }
}
