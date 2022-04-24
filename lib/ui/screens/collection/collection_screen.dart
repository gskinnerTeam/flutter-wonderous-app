import 'package:cached_network_image/cached_network_image.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/collectibles_logic.dart';
import 'package:wonders/logic/data/collectible_data.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/gradient_container.dart';

part 'widgets/_collection_tile.dart';
part 'widgets/_header.dart';
part 'widgets/_collection_list.dart';
part 'widgets/_footer.dart';

// TODO: GDS: scroll to the fromCollectible if possible
// https://stackoverflow.com/questions/49153087/flutter-scrolling-to-a-widget-in-listview
class CollectionScreen extends StatelessWidget with GetItMixin {
  CollectionScreen({this.fromId, Key? key}) : super(key: key);

  final String? fromId;

  @override
  Widget build(BuildContext context) {
    final states = watchX((CollectiblesLogic o) => o.states);
    int discovered = 0, explored = 0, total = collectibles.length;
    states.forEach((_, state) {
      if (state == CollectibleState.discovered) discovered++;
      if (state == CollectibleState.explored) explored++;
    });
    return ColoredBox(
      color: context.colors.greyStrong,
      child: Stack(children: [
        Positioned.fill(
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _Header(newCount: discovered),
            _CollectionList(states: states, fromId: fromId, onPressed: (o) => _showDetails(context, o)),
          ]),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _Footer(count: discovered + explored, total: total),
        ),
      ]),
    );
  }

  void _showDetails(BuildContext context, CollectibleData collectible) {
    context.push(ScreenPaths.artifact(collectible.artifactId));
    Future.delayed(300.ms).then((_) => collectiblesLogic.updateState(collectible.id, CollectibleState.explored));
  }
}
