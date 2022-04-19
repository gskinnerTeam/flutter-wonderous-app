import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
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
  List<ArtifactData?> _searchResultsAll = [];
  String _currentQuery = '';
  bool _isLoading = false;
  bool _isEmpty = false;
  int _startYr = 0;
  int _endYr = 0;

  @override
  void initState() {
    super.initState();
    final data = wondersLogic.getData(widget.type);
    _startYr = data.startYr;
    _endYr = data.endYr;
  }

  void _handleSearchSubmitted(String query) async {
    if (_isLoading) {
      return;
    }

    // Reset the view state; show that it's loading and prevent subsequent calls until complete.
    _currentQuery = query;
    setState(() {
      _isEmpty = false;
      _isLoading = true;
    });

    // Get all search results, with a limit.
    _searchResultsAll = await searchLogic.searchForArtifacts(query, count: 1000, startYear: _startYr, endYear: _endYr);

    // Load complete. Show results.
    setState(() {
      _isLoading = false;
      _isEmpty = _searchResultsAll.isEmpty;
    });
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
    } else if (_isEmpty) {
      resultsText = 'Sorry, no results found';
    } else if (_searchResultsAll.isNotEmpty) {
      resultsText = '${_searchResultsAll.length} results found';
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
                        Text(
                          resultsText,
                          style: context.textStyles.body1.copyWith(color: context.colors.body),
                        ),

                        Gap(context.insets.sm),

                        // Artifacts grid
                        Expanded(
                          child: ArtifactSearchResultsGrid(searchResults: _searchResultsAll, onPressed: onResultClick),
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
