import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/data/wonder_data.dart';

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

  @override
  void initState() {
    // Search test.
    super.initState();
    searchForStuff();
  }

  void searchForStuff() async {
    await search.getAllArtifactIDs();
    await search.getAllDepartments();
    ArtifactData? result = await search.getArtifactByID(search.artifactIDList[0]);
    List<int> results = await search.searchForArtifactsByKeyword(widget.type.name);
    debugPrint(result.toString());
    debugPrint(search.departmentList.toString());
  }

  @override
  Widget build(BuildContext context) {
    /// Collect children for the various layers
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
          child: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
        TextField(
            maxLines: 1,
            decoration: InputDecoration(
                icon: Icon(Icons.search), iconColor: context.style.colors.fg, helperText: 'Search type or material')),
        ...search.artifactIDList.map<Text>((id) => Text(id.toString())).toList(),
      ]))
    ]);
  }
}
