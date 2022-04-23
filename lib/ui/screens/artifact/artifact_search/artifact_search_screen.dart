import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/data/artifact_search_options.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/artifact_search_header.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/artifact_search_results_grid.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/artifact_search_text_field.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/time_range_selector/expanding_time_range_selector.dart';

/// User can use this screen to search the MET server for an artifact by name or timeline. Artifacts results will
/// appear as images, which the user can click on to being up the details view for more information.
class ArtifactSearchScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  ArtifactSearchScreen({Key? key, required this.type}) : super(key: key);
  final WonderType type;

  @override
  State<ArtifactSearchScreen> createState() => _ArtifactSearchScreenState();
}

class _ArtifactSearchScreenState extends State<ArtifactSearchScreen> with GetItStateMixin {
  late ScrollController _gridScrollController;

  final _resultCountPerSearch = 10;

  List<ArtifactData?> _searchResultsAll = [];
  String _currentQuery = '';
  int _resultsCount = 0;
  bool _isLoading = false;
  bool _isEmpty = false;
  bool _isHighlights = true;
  int _startYr = 0;
  int _endYr = 0;

  @override
  void initState() {
    super.initState();
    final data = wondersLogic.getData(widget.type);

    _gridScrollController = ScrollController();
    _gridScrollController.addListener(_handleScroll);
    _startYr = data.artifactStartYr;
    _endYr = data.artifactEndYr;

    _preloadHighlights(data.highlightArtifacts);
  }

  void _preloadHighlights(List<String> data) async {
    // Preloaded highlight data.
    setState(() => _isLoading = true);
    _searchResultsAll = await searchLogic.getArtifactsByID(data);
    setState(() => _isLoading = false);
  }

  void _handleSearchSubmitted(String query) async {
    if (_isLoading) {
      return;
    }

    // Reset the view state; show that it's loading and prevent subsequent calls until complete.
    _currentQuery = query;
    _searchResultsAll = [];

    setState(() {
      _isEmpty = false;
      _isLoading = true;
      _isHighlights = false;
    });

    // Get all search results, with a limit.
    await _callArtifactSearch(query);

    // First load complete. Show results.
    setState(() {
      _resultsCount = searchLogic.lastSearchResultCount;
      _isLoading = false;
      _isEmpty = _searchResultsAll.isEmpty;
    });
  }

  void _handleScroll() async {
    if (_isLoading) return;
    const loadThreshold = 500;
    ScrollPosition pos = _gridScrollController.position;
    final distanceFromEnd = (pos.maxScrollExtent - pos.pixels);
    if (distanceFromEnd < loadThreshold) {
      setState(() => _isLoading = true);
      await _callArtifactSearch(_currentQuery);
      setState(() => _isLoading = false);
    }
  }

  Future<void> _callArtifactSearch(String query) async {
    // Make a new search with the offset in place.
    List<ArtifactData?> data = await searchLogic.searchForArtifacts(ArtifactSearchOptions(
      query: query,
      count: _resultCountPerSearch,
      offset: _searchResultsAll.length,
      startYear: _startYr,
      endYear: _endYr,
    ));
    _searchResultsAll.addAll(data);
  }

  // Re-run the search query when user changes the timeline.
  void _handleTimelineChanged(int start, int end) {
    _startYr = start;
    _endYr = end;
    if (_currentQuery.isNotEmpty) {
      _handleSearchSubmitted(_currentQuery);
    }
  }

  void onResultClick(ArtifactData artifact) {
    // User clicked image. Open Artifact Details view
    context.push(ScreenPaths.artifact(artifact.objectId));
  }

  @override
  Widget build(BuildContext context) {
    final data = wondersLogic.getData(widget.type);

    String resultsText = '';
    if (_isLoading) {
      resultsText = 'Loading, one sec...';
    } else if (_searchResultsAll.isNotEmpty) {
      resultsText = '$_resultsCount results found for: $_currentQuery';
    } else if (_isEmpty) {
      resultsText = 'Sorry, no results found';
    }

    /// Collect children for the various layers
    return Stack(
      children: [
        Positioned.fill(
          child: Flex(
            mainAxisSize: MainAxisSize.max,
            direction: Axis.vertical,
            children: [
              // Header
              SafeArea(
                child: ArtifactSearchHeader(widget.type, 'Browse Artifacts'),
              ),

              // Content
              Expanded(
                child: Container(
                  color: context.colors.offWhite,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.insets.md, vertical: context.insets.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Search box
                        ArtifactSearchTextField(handleSearchSubmitted: _handleSearchSubmitted),

                        Gap(context.insets.sm),

                        // Results feedback
                        if (!_isHighlights) ...[
                          Text(
                            resultsText,
                            style: context.textStyles.body1.copyWith(color: context.colors.body),
                          ),
                          Gap(context.insets.sm),
                        ],

                        // Artifacts grid
                        Expanded(
                          child: ArtifactSearchResultsGrid(
                              searchResults: _searchResultsAll,
                              scrollController: _gridScrollController,
                              onPressed: onResultClick),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Timeline bar
        BottomCenter(
          child: ExpandingTimeRangeSelector(
            wonderType: widget.type,
            location: data.title,
            startYr: 200,
            endYr: 1800,
            onChanged: _handleTimelineChanged,
          ),
        ),
      ],
    );
  }
}
