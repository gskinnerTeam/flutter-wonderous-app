import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/wonders_service.dart';

class WondersServiceMock extends WondersService {
  @override
  Future<List<WonderData>> getWonderData() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      WonderData(
        type: WonderType.petra,
        title: 'Petra',
        desc: lorem(),
        startYr: -100,
        endYr: 100,
        lng: 20.68346184201756,
        lat: -88.56769676930931,
      ),
      WonderData(
        type: WonderType.machuPicchu,
        title: 'Machu Picchu',
        desc: lorem(),
        startYr: -100,
        endYr: 100,
        lng: 40.43186708283783,
        lat: 116.57051301197873,
      ),
      WonderData(
        type: WonderType.petra,
        title: 'Chichen Iza',
        desc: lorem(),
        startYr: -100,
        endYr: 100,
        lng: 20.68346184201756,
        lat: -88.56769676930931,
      ),
      WonderData(
        type: WonderType.machuPicchu,
        title: 'The Great Wall',
        desc: lorem(),
        startYr: -100,
        endYr: 100,
        lng: 40.43186708283783,
        lat: 116.57051301197873,
      ),
      WonderData(
        type: WonderType.petra,
        title: 'Chichen Iza',
        desc: lorem(),
        startYr: -100,
        endYr: 100,
        lng: 20.68346184201756,
        lat: -88.56769676930931,
      ),
      WonderData(
        type: WonderType.machuPicchu,
        title: 'The Great Wall',
        desc: lorem(),
        startYr: -100,
        endYr: 100,
        lng: 40.43186708283783,
        lat: 116.57051301197873,
      ),
      WonderData(
        type: WonderType.petra,
        title: 'Chichen Iza',
        desc: lorem(),
        startYr: -100,
        endYr: 100,
        lng: 20.68346184201756,
        lat: -88.56769676930931,
      ),
      WonderData(
        type: WonderType.machuPicchu,
        title: 'The Great Wall',
        desc: lorem(),
        startYr: -100,
        endYr: 100,
        lng: 40.43186708283783,
        lat: 116.57051301197873,
      ),
    ];
  }
}
