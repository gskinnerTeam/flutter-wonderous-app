import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/search/search_data.dart';
import 'package:wonders/ui/common/cards/glass_card.dart';
import 'package:wonders/ui/common/controls/simple_header.dart';
import 'package:wonders/ui/screens/artifact/artifact_search/time_range_selector/expanding_time_range_selector.dart';

import '../../../common/controls/app_loader.dart';

part 'widgets/_result_tile.dart';
part 'widgets/_results_grid.dart';
part 'widgets/_search_input.dart';

/// User can use this screen to search the MET server for an artifact by name or timeline. Artifacts results will
/// appear as images, which the user can click on to being up the details view for more information.

// TODO: GDS: refactor to match other views.

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
  late double _startYear = wonder.artifactStartYr * 1.0, _endYear = wonder.artifactEndYr * 1.0;
  late PanelController panelController = PanelController(false);

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
      // TODO: improve this search. AND? OR?
      String q = _query.toLowerCase();
      _searchResults = wonder.searchData.where((o) => o.title.contains(q) || o.keywords.contains(q)).toList();
    }
    _filter();
  }

  void _filter() {
    _filteredResults = _searchResults.where((o) => o.year >= _startYear && o.year <= _endYear).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(children: [
      SimpleHeader('Browse Artifacts', subtitle: wonder.title),
      Gap(context.insets.sm),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: context.insets.sm),
        child: _SearchInput(onSubmit: _handleSearchSubmitted),
      ),
      Gap(context.insets.xs),
      Row(children: [
        Gap(context.insets.sm),
        Text(
          '${_searchResults.length} artifacts found, ${_filteredResults.length} in ',
          style: context.textStyles.body,
        ),
        GestureDetector(
            onTap: () => panelController.toggle(),
            child: Text(
              'time range',
              style: context.textStyles.body.copyWith(decoration: TextDecoration.underline),
            )),
        Gap(context.insets.sm),
      ]),
      Gap(context.insets.xs),
      Expanded(
        child: _ResultsGrid(
          searchResults: _filteredResults,
          onPressed: (o) => context.push(ScreenPaths.artifact(o.id.toString())),
        ),
      ),
    ]);

    return Stack(children: [
      Positioned.fill(child: ColoredBox(color: context.colors.offWhite, child: content)),
      Positioned.fill(
        child: ExpandingTimeRangeSelector(
          wonder: wonder,
          startYear: _startYear,
          endYear: _endYear,
          controller: panelController,
          onChanged: _handleTimelineChanged,
        ),
      ),
    ]);
  }
}

class PanelController extends ValueNotifier<bool> {
  PanelController(bool value) : super(value);

  void toggle() => value = !value;
}
