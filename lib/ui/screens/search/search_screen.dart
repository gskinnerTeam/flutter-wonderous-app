import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wonders/ui/common/wonder_illustrations.dart';
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

    InternetConnectionStatus status = (await InternetConnectionChecker().connectionStatus);
    if (status == InternetConnectionStatus.disconnected) {
      setState(() {
        isDisconnected = true;
      });
      return;
    }

    setState(() {
      isEmpty = false;
      isDisconnected = false;
      isLoading = true;
    });

    // Get all search results, with a limit.
    searchResultsAll = await search.searchForArtifacts(query, count: 1000);

    setState(() {
      isLoading = false;
      isEmpty = searchResultsAll.isEmpty;
    });
  }

  void handleImagePressed(ArtifactData artifact) {
    context.push(ScreenPaths.artifact(artifact.objectID.toString()));
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

    /// Collect children for the various layers
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.insets.lg),
        child: CustomScrollView(controller: scrollController, cacheExtent: 2000, slivers: [
          SliverAppBar(
            pinned: true,
            leading: SizedBox.shrink(),
            collapsedHeight: 80,
            flexibleSpace: SafeArea(
                child: Padding(
              padding: EdgeInsets.all(context.insets.lg),
              child: WonderIllustration(widget.type),
            )),
            expandedHeight: context.heightPct(.3),
            backgroundColor: context.colors.accent,
          ),
          SliverToBoxAdapter(
              child: TextField(
                  onSubmitted: searchForStuff,
                  maxLines: 1,
                  decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      iconColor: context.style.colors.fg,
                      helperText: 'Search type or material'))),
          SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.insets.lg),
                  child: Text(resultsText, style: context.textStyles.body))),
          SliverToBoxAdapter(
              child: MasonryGridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: context.insets.sm,
            mainAxisSpacing: context.insets.lg,
            itemCount: searchResultsAll.length,
            clipBehavior: Clip.antiAlias,
            itemBuilder: (BuildContext context, int index) {
              var data = searchResultsAll[index];
              return Padding(
                  padding: EdgeInsets.all(context.insets.lg),
                  child: GestureDetector(
                      onTap: () => handleImagePressed(data!),
                      child: CachedNetworkImage(
                          imageUrl: data!.image,
                          placeholder: (BuildContext context, String url) {
                            return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    border: Border.all(color: context.colors.surface1, width: 3)),
                                child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Center(
                                        heightFactor: 1,
                                        child: CircularProgressIndicator(
                                          color: context.colors.fg,
                                          semanticsLabel: data.title,
                                        ))));
                          })));
            },
          ))
        ]));
  }
}
