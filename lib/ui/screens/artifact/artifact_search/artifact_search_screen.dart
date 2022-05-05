import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';
import 'package:wonders/ui/common/cards/glass_card.dart';
import 'package:wonders/ui/common/controls/simple_header.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/time_range_selector/expanding_time_range_selector.dart';

part 'widgets/_result_tile.dart';
part 'widgets/_results_grid.dart';
part 'widgets/_search_input.dart';

/// TODO: GDS: refactor to match other views.
/// TODO: GDS: add word boundaries to the search
/// https://www.figma.com/file/814LAO3wAzMNbB7YYPZpnZ/Wireframes?node-id=785%3A7621#189648988

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
  late final PanelController panelController = PanelController(false);
  late final SearchVizController vizController = SearchVizController(
    _searchResults,
    minYear: wondersLogic.startYear,
    maxYear: wondersLogic.endYear,
  );
  late double _startYear = wonder.artifactStartYr * 1.0, _endYear = wonder.artifactEndYr * 1.0;

  @override
  void initState() {
    _search();
    super.initState();
  }

  void _handleSearchSubmitted(String query) {
    _query = query;
    _search();
  }

  void _handleTimelineChanged(double start, double end) {
    _startYear = start;
    _endYear = end;
    _filter();
  }

  void _search() {
    if (_query.isEmpty) {
      _searchResults = wonder.searchData;
    } else {
      // this is a somewhat naive search, but is sufficient for demoing the UI:
      final RegExp q = RegExp('\\b${_query}s?\\b', caseSensitive: false);
      _searchResults = wonder.searchData.where((o) => o.title.contains(q) || o.keywords.contains(q)).toList();
    }
    vizController.value = _searchResults;
    _filter();
  }

  void _filter() {
    _filteredResults = _searchResults.where((o) => o.year >= _startYear && o.year <= _endYear).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    vizController.color = context.colors.accent1;
    Widget content = GestureDetector(
        onTap: () => WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus(),
        child: Column(children: [
          SimpleHeader('Browse Artifacts', subtitle: wonder.title),
          Gap(context.insets.xs),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.insets.sm),
            child: _SearchInput(onSubmit: _handleSearchSubmitted),
          ),
          Gap(context.insets.sm),
          Container(
            color: context.colors.black,
            padding: EdgeInsets.all(context.insets.xs * 1.5),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Gap(context.insets.sm),
              Text(
                '${_searchResults.length} artifacts found, ${_filteredResults.length} in ',
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                style: context.textStyles.body.copyWith(color: context.colors.accent1),
              ),
              GestureDetector(
                onTap: () => panelController.toggle(),
                child: Text(
                  'timeframe',
                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  style: context.textStyles.body
                      .copyWith(decoration: TextDecoration.underline, color: context.colors.accent1),
                ),
              ),
              Gap(context.insets.sm),
            ]),
          ),
          Expanded(
            child: RepaintBoundary(
              child: _ResultsGrid(
                searchResults: _filteredResults,
                onPressed: (o) => context.push(ScreenPaths.artifact(o.id.toString())),
              ),
            ),
          ),
        ]));

    return Stack(children: [
      Positioned.fill(child: ColoredBox(color: context.colors.greyStrong, child: content)),
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
