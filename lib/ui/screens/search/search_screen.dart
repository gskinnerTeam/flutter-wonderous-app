import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dart:math' as math;

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
  List<int> searchResultsIds = [];
  List<ArtifactData> searchResultsData = [];
  bool isLoading = false;
  bool isEmpty = false;
  double width = 0;
  double height = 0;

  @override
  void initState() {
    // Search test.
    super.initState();
  }

  void resize() {
    setState(() {
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;
    });
  }

  void searchForStuff(String query) async {
    if (isLoading) {
      return;
    }

    setState(() {
      isEmpty = false;
      isLoading = true;
    });

    searchResultsIds = await search.searchForArtifacts(query);
    populateResultsData(0, 20);
  }

  void populateResultsData(int start, int end) async {
    // Ensure we're not out of bounds.
    end = math.min(end, searchResultsIds.length);
    if (searchResultsIds.isNotEmpty) {
      ArtifactData result;
      // Load in atifact data.
      for (var i = 0, l = math.min(end - start, searchResultsIds.length); i < l; i++) {
        result = await search.getArtifactByID(searchResultsIds[i]) ?? ArtifactData.empty();
        while (searchResultsData.length <= i) {
          searchResultsData.add(ArtifactData.empty());
        }
        searchResultsData[i] = result;
      }

      // Update the list.
      setState(() {
        isLoading = false;
      });
    } else {
      // Empty list.
      setState(() {
        isLoading = false;
        isEmpty = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Collect children for the various layers
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
          child: TextField(
              onSubmitted: searchForStuff,
              maxLines: 1,
              decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  iconColor: context.style.colors.fg,
                  helperText: 'Search type or material'))),
      if (isLoading) SliverToBoxAdapter(child: Text('Loading, one sec...', style: context.textStyles.body)),
      if (isEmpty) SliverToBoxAdapter(child: Text('Sorry, no results found.', style: context.textStyles.body)),
      SliverToBoxAdapter(
          child: MasonryGridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
        itemCount: searchResultsData.length,
        clipBehavior: Clip.antiAlias,
        itemBuilder: (BuildContext context, int index) {
          var data = searchResultsData[index];
          return Image.network(data.image);
        },
      ))
    ]);
  }
}
