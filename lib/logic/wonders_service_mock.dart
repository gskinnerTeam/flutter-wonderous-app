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
          imageIds: mockImageIds),
      WonderData(
          type: WonderType.machuPicchu,
          title: 'Machu Picchu',
          desc: lorem(),
          startYr: -100,
          endYr: 100,
          lng: 40.43186708283783,
          lat: 116.57051301197873,
          imageIds: mockImageIds),
      WonderData(
          type: WonderType.petra,
          title: 'Chichen Iza',
          desc: lorem(),
          startYr: -100,
          endYr: 100,
          lng: 20.68346184201756,
          lat: -88.56769676930931,
          imageIds: mockImageIds),
      WonderData(
          type: WonderType.machuPicchu,
          title: 'The Great Wall',
          desc: lorem(),
          startYr: -100,
          endYr: 100,
          lng: 40.43186708283783,
          lat: 116.57051301197873,
          imageIds: mockImageIds),
      WonderData(
          type: WonderType.petra,
          title: 'Chichen Iza',
          desc: lorem(),
          startYr: -100,
          endYr: 100,
          lng: 20.68346184201756,
          lat: -88.56769676930931,
          imageIds: mockImageIds),
      WonderData(
          type: WonderType.machuPicchu,
          title: 'The Great Wall',
          desc: lorem(),
          startYr: -100,
          endYr: 100,
          lng: 40.43186708283783,
          lat: 116.57051301197873,
          imageIds: mockImageIds),
      WonderData(
          type: WonderType.petra,
          title: 'Chichen Iza',
          desc: lorem(),
          startYr: -100,
          endYr: 100,
          lng: 20.68346184201756,
          lat: -88.56769676930931,
          imageIds: mockImageIds),
      WonderData(
          type: WonderType.machuPicchu,
          title: 'The Great Wall',
          desc: lorem(),
          startYr: -100,
          endYr: 100,
          lng: 40.43186708283783,
          lat: 116.57051301197873,
          imageIds: mockImageIds),
    ];
  }
}

List<String> mockImageIds = [
  'NtrJ4CvPkss',
  'XXzkz-kMUbI',
  'huMh6cfhl_o',
  'B6ujEHbDzLI',
  'OYGN7McXKCM',
  'cknlJvk2b0k',
  'GiKeMSOQx90',
  'SoDQjg8KrXU',
  'fWwbey8kkSY',
  'BLIP_nrgCyw',
  'OqagFRB9s-k',
  'C4DDUh6V_6s',
  '_iklK8oQKPs',
  'ZN5UCuMHO2U',
  'dqxr8A7Twwc',
  '3bENUVe9MWY',
  'Yt0GMo9DcTg',
  'hds60mCxbPg',
  'Kswnnx95_YU',
  '0BYdWKKZyRU',
  'S940kwmt1b4',
  'CTCWieOBymI',
  'eUobvePZrec',
  'akmU0QwS-wY',
  'cwqwqnHL5Vc',
];
