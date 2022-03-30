import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/logic/data/wonders/mock.dart';

final tajMahalData = WonderData(
  type: WonderType.tajMahal,
  title: 'Taj Mahal',
  desc: lorem(),
  startYr: -100,
  endYr: 100,
  lng: 20.68346184201756,
  lat: -88.56769676930931,
  imageIds: mockImageIds,
);
