import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/save_load_mixin.dart';
import 'package:wonders/logic/data/collectible_data.dart';

class CollectiblesLogic with SaveLoadMixin {
  @override
  String get fileName => 'collectibles.dat';

  final states = ValueNotifier<Map<String, int>>({});

  @override
  void copyFromJson(Map<String, dynamic> value) {
    Map<String, int> states = {};
    for (int i = 0; i < collectibles.length; i++) {
      String id = collectibles[i].id;
      states[id] = value[id] ?? CollectibleState.lost;
    }
    this.states.value = states;
  }

  void updateState(String id, int state) {
    Map<String, int> states = Map.from(this.states.value);
    states[id] = state;
    this.states.value = states;
    scheduleSave();
  }

  void reset() {
    Map<String, int> states = {};
    for (int i = 0; i < collectibles.length; i++) {
      states[collectibles[i].id] = CollectibleState.lost;
    }
    this.states.value = states;
    debugPrint('collection reset');
    scheduleSave();
  }

  @override
  Map<String, dynamic> toJson() {
    return states.value;
  }
}
