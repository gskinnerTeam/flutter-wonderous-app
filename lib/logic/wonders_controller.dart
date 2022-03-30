import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders/chichen_itza.dart';
import 'package:wonders/logic/data/wonders/colosseum.dart';
import 'package:wonders/logic/data/wonders/taj_mahal.dart';

class WondersController {
  ValueNotifier<List<WonderData>> all = ValueNotifier([chichenItzaData, tajMahalData, colosseumData]);

  WonderData byType(WonderType value) {
    WonderData? result = all.value.firstWhereOrNull((w) => w.type == value);
    if (result == null) throw ('Could not find data for wonder type $value');
    return result;
  }
}
