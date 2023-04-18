import 'package:wonders/common_libs.dart';
import 'package:wonders/ui/common/lazy_indexed_stack.dart';
import 'package:wonders/ui/common/measurable_widget.dart';
import 'package:wonders/ui/screens/artifact/artifact_carousel/artifact_carousel_screen.dart';
import 'package:wonders/ui/screens/editorial/editorial_screen.dart';
import 'package:wonders/ui/screens/photo_gallery/photo_gallery.dart';
import 'package:wonders/ui/screens/wonder_details/wonder_details_tab_menu.dart';
import 'package:wonders/ui/screens/wonder_events/wonder_events.dart';

class WonderDetailsScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  WonderDetailsScreen({Key? key, required this.type, this.initialTabIndex = 0}) : super(key: key);
  final WonderType type;
  final int initialTabIndex;

  @override
  State<WonderDetailsScreen> createState() => _WonderDetailsScreenState();
}

class _WonderDetailsScreenState extends State<WonderDetailsScreen>
    with GetItStateMixin, SingleTickerProviderStateMixin {
  late final _tabController = TabController(
    length: 4,
    vsync: this,
    initialIndex: widget.initialTabIndex,
  )..addListener(_handleTabChanged);
  AnimationController? _fade;

  final _detailsHasScrolled = ValueNotifier(false);
  double? _tabBarSize;
  bool _useNavRail = false;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChanged() {
    _fade?.forward(from: 0);
    setState(() {});
  }

  void _handleDetailsScrolled(double scrollPos) => _detailsHasScrolled.value = scrollPos > 0;

  void _handleTabMenuSized(Size size) {
    setState(() {
      _tabBarSize = (_useNavRail ? size.width : size.height) - WonderDetailsTabMenu.buttonInset;
    });
  }

  @override
  Widget build(BuildContext context) {
    _useNavRail = context.isLandscape && context.heightPx < 900;

    final wonder = wondersLogic.getData(widget.type);
    int tabIndex = _tabController.index;
    bool showTabBarBg = tabIndex != 1;
    final tabBarSize = _tabBarSize ?? 0;
    final menuPadding = _useNavRail ? EdgeInsets.only(left: tabBarSize) : EdgeInsets.only(bottom: tabBarSize);
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        children: [
          /// Fullscreen tab views
          LazyIndexedStack(
            index: _tabController.index,
            children: [
              WonderEditorialScreen(wonder, onScroll: _handleDetailsScrolled),
              PhotoGallery(collectionId: wonder.unsplashCollectionId, wonderType: wonder.type),
              AnimatedPadding(
                duration: $styles.times.fast,
                curve: Curves.easeOut,
                padding: menuPadding,
                child: ArtifactCarouselScreen(type: wonder.type),
              ),
              AnimatedPadding(
                duration: $styles.times.fast,
                curve: Curves.easeOut,
                padding: menuPadding,
                child: WonderEvents(type: widget.type),
              ),
            ],
          ),

          /// Tab menu
          Align(
            alignment: _useNavRail ? Alignment.centerLeft : Alignment.bottomCenter,
            child: ValueListenableBuilder<bool>(
              valueListenable: _detailsHasScrolled,
              builder: (_, value, ___) => MeasurableWidget(
                onChange: _handleTabMenuSized,

                /// Animate the menu in when the axis changes
                child: Animate(
                  key: ValueKey(_useNavRail),
                  effects: [
                    FadeEffect(begin: 0, delay: $styles.times.fast),
                    SlideEffect(begin: _useNavRail ? Offset(-.2, 0) : Offset(0, .2)),
                  ],
                  child: WonderDetailsTabMenu(
                      tabController: _tabController,
                      wonderType: wonder.type,
                      showBg: showTabBarBg,
                      axis: _useNavRail ? Axis.vertical : Axis.horizontal),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
