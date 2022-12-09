import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';
import 'package:wonders/ui/common/app_icons.dart';
import 'package:wonders/ui/common/controls/simple_header.dart';
import 'package:wonders/ui/common/static_text_scale.dart';
import 'package:wonders/ui/common/utils/app_haptics.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/time_range_selector/expanding_time_range_selector.dart';

part 'widgets/_result_tile.dart';
part 'widgets/_results_grid.dart';
part 'widgets/_search_input.dart';

/// User can use this screen to search the MET server for an artifact by name or timeline. Artifacts results will
/// appear as images, which the user can click on to being up the details view for more information.
class ArtifactSearchScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  ArtifactSearchScreen({Key? key, required this.type}) : super(key: key);
  final WonderType type;

  @override
  State<ArtifactSearchScreen> createState() => _ArtifactSearchScreenState();
}

class _ArtifactSearchScreenState extends State<ArtifactSearchScreen> with GetItStateMixin {
  List<SearchData> _searchResults = [];
  List<SearchData> _filteredResults = [];
  String _query = '';

  late final WonderData wonder = wondersLogic.getData(widget.type);
  late final PanelController panelController = PanelController(true);
  late final SearchVizController vizController = SearchVizController(
    _searchResults,
    minYear: wondersLogic.timelineStartYear,
    maxYear: wondersLogic.timelineEndYear,
  );
  late double _startYear = wonder.artifactStartYr * 1.0, _endYear = wonder.artifactEndYr * 1.0;

  @override
  void initState() {
    _updateResults();
    panelController.addListener(() {
      AppHaptics.lightImpact();
    });
    super.initState();
  }

  void _handleSearchSubmitted(String query) {
    _query = query;
    _updateResults();
  }

  void _handleTimelineChanged(double start, double end) {
    _startYear = start;
    _endYear = end;
    _updateFilter();
  }

  void _handleResultPressed(SearchData o) => context.push(ScreenPaths.artifact(o.id.toString()));

  void _updateResults() {
    if (_query.isEmpty) {
      _searchResults = wonder.searchData;
    } else {
      // whole word search on title and keywords.
      // this is a somewhat naive search, but is sufficient for demoing the UI.
      final RegExp q = RegExp('\\b${_query}s?\\b', caseSensitive: false);
      _searchResults = wonder.searchData.where((o) => o.title.contains(q) || o.keywords.contains(q)).toList();
    }
    vizController.value = _searchResults;
    _updateFilter();
  }

  void _updateFilter() {
    _filteredResults = _searchResults.where((o) => o.year >= _startYear && o.year <= _endYear).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // tone down the orange just a bit:
    vizController.color = Color.lerp($styles.colors.accent1, $styles.colors.black, 0.2)!;
    Widget content = GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SimpleHeader($strings.artifactsSearchTitleBrowse, subtitle: wonder.title),
          Gap($styles.insets.xs),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
            child: _SearchInput(onSubmit: _handleSearchSubmitted, wonder: wonder),
          ),
          Gap($styles.insets.sm),
          Container(
            color: $styles.colors.black,
            padding: EdgeInsets.all($styles.insets.xs * 1.5),
            child: _buildStatusText(context),
          ),
          Expanded(
            child: RepaintBoundary(
              child: _filteredResults.isEmpty
                  ? _buildEmptyIndicator(context)
                  : _ResultsGrid(
                      searchResults: _filteredResults,
                      onPressed: _handleResultPressed,
                    ),
            ),
          ),
        ],
      ),
    );

    return Stack(children: [
      Positioned.fill(child: ColoredBox(color: $styles.colors.greyStrong, child: content)),
      Positioned.fill(
        child: RepaintBoundary(
          child: ExpandingTimeRangeSelector(
            wonder: wonder,
            startYear: _startYear,
            endYear: _endYear,
            panelController: panelController,
            vizController: vizController,
            onChanged: _handleTimelineChanged,
          ),
        ),
      ),
    ]);
  }

  Widget _buildStatusText(BuildContext context) {
    final TextStyle statusStyle = $styles.text.body.copyWith(color: $styles.colors.accent1);
    if (_searchResults.isEmpty) {
      return StaticTextScale(
        child: Text(
          $strings.artifactsSearchLabelNotFound,
          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
          style: statusStyle,
          textAlign: TextAlign.center,
        ),
      );
    }
    return MergeSemantics(
      child: StaticTextScale(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Gap($styles.insets.sm),
          Text(
            $strings.artifactsSearchLabelFound(_searchResults.length, _filteredResults.length),
            textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
            style: statusStyle,
          ),
          AppBtn.basic(
            semanticLabel: $strings.artifactsSearchButtonToggle,
            onPressed: () => panelController.toggle(),
            enableFeedback: false, // handled when panelController changes.
            child: Text(
              $strings.artifactsSearchSemanticTimeframe,
              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
              style: statusStyle.copyWith(decoration: TextDecoration.underline),
            ),
          ),
          Gap($styles.insets.sm),
        ]),
      ),
    );
  }

  Widget _buildEmptyIndicator(BuildContext context) {
    final strings = $strings;
    String text =
        '${strings.artifactsSearchLabelAdjust} ${_searchResults.isEmpty ? strings.artifactsSearchLabelSearch : strings.artifactsSearchLabelTimeframe}';
    IconData icon = _searchResults.isEmpty ? Icons.search_outlined : Icons.edit_calendar_outlined;
    Color color = $styles.colors.greyMedium;
    Widget widget = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        Icon(icon, size: $styles.insets.xl, color: color.withOpacity(0.5)),
        Gap($styles.insets.xs),
        Text(text, style: $styles.text.body.copyWith(color: color)),
        Spacer(
          flex: 3,
        ),
      ],
    );
    if (_searchResults.isNotEmpty) {
      widget = GestureDetector(child: widget, onTap: () => panelController.toggle());
    }
    return widget;
  }
}

class PanelController extends ValueNotifier<bool> {
  PanelController(bool value) : super(value);
  void toggle() => value = !value;
}

// this is basically a ValueNotifier, but it always notifies when the value is assigned, w/o checking equality.
class SearchVizController extends ChangeNotifier {
  SearchVizController(
    List<SearchData> value, {
    required this.minYear,
    required this.maxYear,
    this.color = Colors.black,
  }) : _value = value;

  Color color;
  final int minYear;
  final int maxYear;

  List<SearchData> _value;
  List<SearchData> get value => _value;
  set value(List<SearchData> value) {
    _value = value;
    notifyListeners();
  }
}
