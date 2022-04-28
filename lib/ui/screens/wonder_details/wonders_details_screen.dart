import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/lazy_indexed_stack.dart';
import 'package:wonders/ui/screens/artifact/artifact_carousel/artifact_carousel_screen.dart';
import 'package:wonders/ui/screens/editorial/editorial_screen.dart';
import 'package:wonders/ui/screens/photo_gallery/photo_gallery.dart';
import 'package:wonders/ui/screens/timeline/timeline_screen.dart';
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
    initialIndex: AppLogic.enablePersistentTabs ? appLogic.selectedWondersTab.value : 0,
  )..addListener(_handleTabChanged);
  AnimationController? _fade;

  final _detailsHasScrolled = ValueNotifier(false);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChanged() {
    _fade?.forward(from: 0);
    // Hoist the selected tab up to the app controller, so it will be remembered when we return to this view.
    appLogic.selectedWondersTab.value = _tabController.index;
    setState(() {});
  }

  void _handleDetailsScrolled(double scrollPos) => _detailsHasScrolled.value = scrollPos > 0;

  @override
  Widget build(BuildContext context) {
    final wonder = wondersLogic.getData(widget.type);
    int tabIndex = _tabController.index;
    bool showTabBarBg = tabIndex != 1;
    // TODO: Need a better way to get the height of the tab bar here... options? MeasuredWidget, static height, app.tabBarHeight?
    final double tabBarHeight = context.mq.padding.bottom + 75;
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        children: [
          /// Fullscreen tab views
          LazyIndexedStack(
            index: _tabController.index,
            children: [
              WonderEditorialScreen(wonder, onScroll: _handleDetailsScrolled),
              PhotoGallery(collectionId: wonder.unsplashCollectionId),
              Padding(padding: EdgeInsets.only(bottom: tabBarHeight), child: ArtifactCarouselScreen(type: wonder.type)),
              Padding(padding: EdgeInsets.only(bottom: tabBarHeight), child: TimelineScreen(type: widget.type)),
            ],
          ),

          /// Tab menu
          BottomCenter(
            child: ValueListenableBuilder<bool>(
              valueListenable: _detailsHasScrolled,
              builder: (_, value, ___) => WonderDetailsTabMenu(
                tabController: _tabController,
                wonderType: wonder.type,
                showBg: showTabBarBg,
                showHomeBtn: value || tabIndex != 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
