import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/chichen_itza_data.dart';
import 'package:wonders/logic/data/wonders_data/taj_mahal_data.dart';

class WondersLogic {
  ValueNotifier<List<WonderData>> all = ValueNotifier([chichenItzaData, tajMahalData]);

  WonderData getDataForType(WonderType value) {
    WonderData? result = all.value.firstWhereOrNull((w) => w.type == value);
    if (result == null) throw ('Could not find data for wonder type $value');
    return result;
  }
}