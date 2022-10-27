import 'dart:async';

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/collectibles_logic.dart';
import 'package:wonders/logic/common/string_utils.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/controls/simple_header.dart';
import 'package:wonders/ui/common/gradient_container.dart';
import 'package:wonders/ui/common/modals/app_modals.dart';

part 'widgets/_collection_tile.dart';
part 'widgets/_newly_discovered_row.dart';
part 'widgets/_collection_list.dart';
part 'widgets/_collection_footer.dart';

class CollectionScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  CollectionScreen({required this.fromId, Key? key}) : super(key: key);

  final String fromId;

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> with GetItStateMixin {
  Map<String, int> _states = collectiblesLogic.statesById.value;
  GlobalKey? _scrollKey;

  WonderType? get scrollTargetWonder {
    String? id = widget.fromId;
    if (_states[id] != CollectibleState.discovered) {
      id = _states.keys.firstWhereOrNull((id) => _states[id] == CollectibleState.discovered);
    }
    return collectiblesLogic.fromId(id)?.wonder;
  }

  @override
  void initState() {
    super.initState();
    if (widget.fromId.isNotEmpty && _states[widget.fromId] == CollectibleState.discovered) {
      scheduleMicrotask(() => _scrollToTarget(false));
    }
  }

  void _scrollToTarget([bool animate = true]) {
    if (_scrollKey != null) {
      Scrollable.ensureVisible(_scrollKey!.currentContext!, alignment: 0.15, duration: animate ? 300.ms : 0.ms);
    }
  }

  void _showDetails(BuildContext context, CollectibleData collectible) {
    context.push(ScreenPaths.artifact(collectible.artifactId));
    Future.delayed(300.ms).then((_) => collectiblesLogic.updateState(collectible.id, CollectibleState.explored));
  }

  void _handleReset() async {
    String msg = $strings.collectionPopupResetConfirm;
    final result = await showModal(context, child: OkCancelModal(msg: msg));
    if (result == true) {
      collectiblesLogic.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    _states = watchX((CollectiblesLogic o) => o.statesById);
    int discovered = 0, explored = 0, total = collectiblesLogic.all.length;
    _states.forEach((_, state) {
      if (state == CollectibleState.discovered) discovered++;
      if (state == CollectibleState.explored) explored++;
    });

    WonderType? scrollWonder = scrollTargetWonder;
    if (scrollWonder != null) _scrollKey = GlobalKey();

    return ColoredBox(
      color: $styles.colors.greyStrong,
      child: Column(
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              SimpleHeader($strings.collectionTitleCollection),
              _NewlyDiscoveredRow(count: discovered, onPressed: _scrollToTarget),
              Flexible(
                child: _CollectionList(
                  states: _states,
                  fromId: widget.fromId,
                  scrollKey: _scrollKey,
                  scrollWonder: scrollWonder,
                  onPressed: (o) => _showDetails(context, o),
                  onReset: discovered + explored > 0 ? _handleReset : null,
                ),
              ),
            ]),
          ),
          _CollectionFooter(count: discovered + explored, total: total),
        ],
      ),
    );
  }
}
