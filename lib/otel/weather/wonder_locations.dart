import 'package:wonders/logic/data/wonder_type.dart';

class WonderLocation {
  final double latitude;
  final double longitude;
  final String name;

  const WonderLocation({
    required this.latitude,
    required this.longitude,
    required this.name,
  });
}

Map<WonderType, WonderLocation> wonderLocations = {
  WonderType.chichenItza: WonderLocation(
    latitude: 20.6843,
    longitude: -88.5678,
    name: 'Chichen Itza',
  ),
  WonderType.christRedeemer: WonderLocation(
    latitude: -22.9519,
    longitude: -43.2105,
    name: 'Christ the Redeemer',
  ),
  WonderType.colosseum: WonderLocation(
    latitude: 41.8902,
    longitude: 12.4922,
    name: 'Colosseum',
  ),
  WonderType.greatWall: WonderLocation(
    latitude: 40.4319,
    longitude: 116.5704,
    name: 'Great Wall of China',
  ),
  WonderType.machuPicchu: WonderLocation(
    latitude: -13.1631,
    longitude: -72.5450,
    name: 'Machu Picchu',
  ),
  WonderType.petra: WonderLocation(
    latitude: 30.3285,
    longitude: 35.4444,
    name: 'Petra',
  ),
  WonderType.pyramidsGiza: WonderLocation(
    latitude: 29.9792,
    longitude: 31.1342,
    name: 'Pyramids of Giza',
  ),
  WonderType.tajMahal: WonderLocation(
    latitude: 27.1751,
    longitude: 78.0421,
    name: 'Taj Mahal',
  ),
};
