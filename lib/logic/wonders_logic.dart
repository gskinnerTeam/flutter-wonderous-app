import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders_data/chichen_itza_data.dart';
import 'package:wonders/logic/data/wonders_data/christ_redeemer_data.dart';
import 'package:wonders/logic/data/wonders_data/colosseum_data.dart';
import 'package:wonders/logic/data/wonders_data/great_wall_data.dart';
import 'package:wonders/logic/data/wonders_data/machu_picchu_data.dart';
import 'package:wonders/logic/data/wonders_data/petra_data.dart';
import 'package:wonders/logic/data/wonders_data/pyramids_giza_data.dart';
import 'package:wonders/logic/data/wonders_data/taj_mahal_data.dart';

class WondersLogic {
  final List<WonderData> all = [
    chichenItzaData,
    christRedeemerData,
    colosseumData,
    greatWallData,
    machuPicchuData,
    petraData,
    pyramidsGizaData,
    tajMahalData
  ];

  ///SB: Used to determine which wonders actually get shown on HomeView, TODO: For debug / testing only, remove once all wonders are working
  final List<WonderData> enabled = [
    chichenItzaData,
    tajMahalData,
  ];

  //TODO: @Grant, can put collectibleIds here, and bind the collectibles view to this
  final foundCollectibleIds = ValueNotifier<List<String>>([]);

  WonderData getData(WonderType value) {
    WonderData? result = all.firstWhereOrNull((w) => w.type == value);
    if (result == null) throw ('Could not find data for wonder type $value');
    return result;
  }
}
