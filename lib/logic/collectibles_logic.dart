import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/save_load_mixin.dart';
import 'package:wonders/logic/data/collectible_data.dart';

/// TODO SB: Implement hidden collectibles.
/// Each view will ask for a specific index, like getCollectible(wonder.type, index: 0), and it will place it somewhere in the UI using custom logic.
/// In the editorial view, this will be somewhere within 3 common spots,
/// in image-grid, we can distribute it anywhere (in a deterministic way)
/// in search, we can tie it into a specific year value, which will cause it to be revealed.
class CollectiblesLogic with SaveLoadMixin {
  @override
  String get fileName => 'collectibles.dat';

  final states = ValueNotifier<Map<String, int>>({});

  void updateState(String id, int state) {
    Map<String, int> states = Map.of(this.states.value);
    states[id] = state;
    this.states.value = states;
    scheduleSave();
  }

  void reset() {
    List<CollectibleData> collectibles = CollectibleData.all;
    Map<String, int> states = {};
    for (int i = 0; i < collectibles.length; i++) {
      states[collectibles[i].id] = CollectibleState.lost;
    }
    this.states.value = states;
    debugPrint('collection reset');
    scheduleSave();
  }

  @override
  void copyFromJson(Map<String, dynamic> value) {
    List<CollectibleData> collectibles = CollectibleData.all;
    Map<String, int> states = {};
    for (int i = 0; i < collectibles.length; i++) {
      String id = collectibles[i].id;
      states[id] = value[id] ?? CollectibleState.lost;
    }
    this.states.value = states;
  }

  @override
  Map<String, dynamic> toJson() {
    return states.value;
  }
}
