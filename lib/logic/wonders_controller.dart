import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/wonders_service.dart';

class WondersController {
  ValueNotifier<List<WonderData>> all = ValueNotifier([]);

  Future<void> init() async {
    all.value = await GetIt.I.get<WondersService>().getWonderData();
  }
}
