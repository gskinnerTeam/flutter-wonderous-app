import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/wonders_controller.dart';
import 'package:wonders/ui/common/swipeable_image_grid/swipeable_image_grid.dart';
import 'package:wonders/ui/screens/timeline/timeline_screen.dart';
import 'package:wonders/ui/screens/wonder_details/wonder_details_bottom_menu.dart';
import 'package:wonders/ui/screens/wonder_details/wonder_history_panel.dart';

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

  @override
  Widget build(BuildContext context) {
    final wonders = watchX((WondersController w) => w.all);
    WonderData? wonder = wonders.firstWhereOrNull((w) => w.type == widget.type);
    wonder ??= wonders.first;

    return ColoredBox(
      color: Colors.black,
      child: Stack(
        children: [
          IndexedStack(
            index: _tabController.index,
            children: [
              WonderHistoryPanel(wonder),
              SwipeableImageGrid(),
              Center(child: Text('Artifacts', style: context.textStyles.h1)),
              Padding(padding: EdgeInsets.only(bottom: 80), child: TimelineScreen(type: widget.type)),
            ],
          ).gTweener.fade().withInit((t) => _fade = t),
          BottomCenter(child: WonderDetailsBottomMenu(tabController: _tabController)),
        ],
      ),
    );
  }
}
