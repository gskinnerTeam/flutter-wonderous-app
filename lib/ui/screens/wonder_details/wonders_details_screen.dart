import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/wonders_controller.dart';
import 'package:wonders/ui/common/swipeable_image_grid/swipeable_image_grid.dart';
import 'package:wonders/ui/common/wonder_illustrations.dart';
import 'package:wonders/ui/screens/timeline/timeline_screen.dart';
import 'package:wonders/ui/screens/wonder_details/wonder_details_bottom_menu.dart';

class WonderDetailsScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  WonderDetailsScreen({Key? key, required this.type}) : super(key: key);
  final WonderType type;

  @override
  State<WonderDetailsScreen> createState() => _WonderDetailsScreenState();
}

class _WonderDetailsScreenState extends State<WonderDetailsScreen>
    with GetItStateMixin, SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 4, vsync: this)..addListener(_handleTabChanged);
  GTweenerController? _fade;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChanged() {
    _fade?.forward(from: 0);
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
          /// Content & Tab Menu
          Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: _tabController.index,
                  children: [
                    _WonderHistory(wonder),
                    SwipeableImageGrid(),
                    Center(child: Text('Artifacts', style: context.textStyles.h1)),
                    TimelineScreen(type: widget.type),
                  ],
                ).gTweener.fade().withInit((t) => _fade = t),
              ),
              WonderDetailsBottomMenu(tabController: _tabController),
            ],
          ),

          /// Shared "Up" btn
          Padding(
            padding: EdgeInsets.all(context.insets.lg),
            child: Transform.rotate(angle: pi * .5, child: BackButton()),
          ),
        ],
      ),
    );
  }
}

class _WonderHistory extends StatelessWidget {
  const _WonderHistory(this.data, {Key? key}) : super(key: key);
  final WonderData data;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          leading: SizedBox.shrink(),
          collapsedHeight: 80,
          flexibleSpace: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(context.insets.lg),
            child: WonderIllustration(data.type),
          )),
          expandedHeight: context.heightPct(.3),
          backgroundColor: context.colors.accent,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(context.insets.lg),
            child: SeparatedColumn(
              separatorBuilder: () => Gap(context.insets.xl),
              children: const [
                PlaceholderLines(count: 3),
                Placeholder(fallbackHeight: 300),
                PlaceholderLines(count: 6),
                Placeholder(fallbackHeight: 300),
                PlaceholderLines(count: 6),
              ],
            ),
          ),
        )
      ],
    );
  }
}
