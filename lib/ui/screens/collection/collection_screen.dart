import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/collectibles_logic.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/controls/simple_header.dart';
import 'package:wonders/ui/common/gradient_container.dart';

part 'widgets/_collection_tile.dart';
part 'widgets/_newly_discovered_row.dart';
part 'widgets/_collection_list.dart';
part 'widgets/_collection_footer.dart';

// TODO: GDS: maybe refactor so that the "new item" header scrolls to the first new item when clicked.

class CollectionScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  CollectionScreen({this.fromId, Key? key}) : super(key: key);

  final String? fromId;

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> with GetItStateMixin {
  Map<String, int> states = collectiblesLogic.states.value;
  GlobalKey? scrollKey;

  @override
  void initState() {
    super.initState();
    if (widget.fromId != null && states[widget.fromId] == CollectibleState.discovered) {
      WidgetsBinding.instance?.addPostFrameCallback((_) => _scrollToTarget(false));
    }
  }

  WonderType? get scrollTargetWonder {
    String? id = widget.fromId;
    if (id == null || states[id] != CollectibleState.discovered) {
      id = states.keys.firstWhereOrNull((id) => states[id] == CollectibleState.discovered);
    }
    return CollectibleData.fromId(id)?.wonder;
  }

  void _scrollToTarget([bool animate = true]) {
    if (scrollKey != null) {
      Scrollable.ensureVisible(scrollKey!.currentContext!, alignment: 0.15, duration: animate ? 300.ms : 0.ms);
    }
  }

  void _showDetails(BuildContext context, CollectibleData collectible) {
    context.push(ScreenPaths.artifact(collectible.artifactId));
    Future.delayed(300.ms).then((_) => collectiblesLogic.updateState(collectible.id, CollectibleState.explored));
  }

  @override
  Widget build(BuildContext context) {
    states = watchX<CollectiblesLogic, Map<String, int>>((o) => o.states);
    int discovered = 0, explored = 0, total = CollectibleData.all.length;
    states.forEach((_, state) {
      if (state == CollectibleState.discovered) discovered++;
      if (state == CollectibleState.explored) explored++;
    });

    WonderType? scrollWonder = scrollTargetWonder;
    if (scrollWonder != null) scrollKey = GlobalKey();

    return ColoredBox(
      color: context.colors.greyStrong,
      child: Stack(children: [
        Positioned.fill(
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SimpleHeader('Collection'),
            _NewlyDiscoveredRow(count: discovered, onPressed: _scrollToTarget),
            _CollectionList(
              states: states,
              fromId: widget.fromId,
              scrollKey: scrollKey,
              scrollWonder: scrollWonder,
              onPressed: (o) => _showDetails(context, o),
            ),
          ]),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _CollectionFooter(count: discovered + explored, total: total),
        ),
      ]),
    );
  }
}
