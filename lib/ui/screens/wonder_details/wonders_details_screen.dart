import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/wonders_controller.dart';
import 'package:wonders/ui/common/controls/buttons.dart';
import 'package:wonders/ui/screens/artifact_search/artifact_search_screen.dart';
import 'package:wonders/ui/screens/image_gallery/image_gallery.dart';
import 'package:wonders/ui/screens/timeline/timeline_screen.dart';
import 'package:wonders/ui/screens/wonder_details/editorial/wonder_editorial_screen.dart';
import 'package:wonders/ui/screens/wonder_details/wonder_details_tab_menu.dart';

class WonderDetailsScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  WonderDetailsScreen({Key? key, required this.type}) : super(key: key);
  final WonderType type;

  @override
  State<WonderDetailsScreen> createState() => _WonderDetailsScreenState();
}

class _WonderDetailsScreenState extends State<WonderDetailsScreen>
    with GetItStateMixin, SingleTickerProviderStateMixin {
  late final _tabController = TabController(
    length: 4,
    vsync: this,
    initialIndex: app.selectedWondersTab.value,
  )..addListener(_handleTabChanged);
  GTweenerController? _fade;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChanged() {
    _fade?.forward(from: 0);
    // Hoist the selected tab up to the app controller, so it will be remembered when we return to this view.
    app.selectedWondersTab.value = _tabController.index;
    setState(() {});
  }

  void _handleSettingsPressed() => context.push(ScreenPaths.settings);
  @override
  Widget build(BuildContext context) {
    final wonders = watchX((WondersController w) => w.all);
    WonderData? wonder = wonders.firstWhereOrNull((w) => w.type == widget.type);
    wonder ??= wonders.first;
    int tabIndex = _tabController.index;
    bool showTabBarBg = tabIndex != 1;
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        children: [
          IndexedStack(
            index: _tabController.index,
            children: [
              WonderEditorialScreen(wonder),
              ImageGallery(photoIds: wonder.imageIds),
              // TODO: Need a better way to get the height of the tab bar here... options? MeasuredWidget, Hardcoded height,
              Padding(padding: EdgeInsets.only(bottom: 48), child: ArtifactSearchScreen(type: widget.type)),
              Padding(padding: EdgeInsets.only(bottom: 48), child: TimelineScreen(type: widget.type)),
            ],
          ).gTweener.fade().withInit((t) => _fade = t),
          TopRight(child: AppBtn(child: Text('Settings'), onPressed: _handleSettingsPressed)),
          BottomCenter(
            child: WonderDetailsTabMenu(
              tabController: _tabController,
              wonderType: wonder.type,
              showBg: showTabBarBg,
            ),
          ),
        ],
      ),
    );
  }
}
