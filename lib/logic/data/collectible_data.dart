import 'package:wonders/common_libs.dart';

class CollectedState {
  static const int hidden = 0;
  static const int found = 1;
  static const int explored = 2;
}

class CollectibleData {
  CollectibleData({
    required this.title,
    required this.imageUrl,
    required this.iconName,
    required this.artifactId,
    required this.wonder,
  }) {
    icon = AssetImage('${ImagePaths.collectibleIcons}/$iconName.png');
  }

  final String title;
  final String imageUrl;
  final String iconName;

  late final ImageProvider icon;

  final String artifactId;
  final WonderType wonder;

  String get id => artifactId;
  String get subtitle => wondersLogic.getData(wonder).artifactCulture;
}

// todo: check which image size we should be using.
List<CollectibleData> collectibles = [
// chichenItza
  CollectibleData(
    title: 'Pendant',
    wonder: WonderType.chichenItza,
    artifactId: '701645',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/DP701440.jpg',
    iconName: 'camera',
  ),
  CollectibleData(
    title: 'Bird Ornament',
    wonder: WonderType.chichenItza,
    artifactId: '310555',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/DP-23474-001.jpg',
    iconName: 'jewelry',
  ),
  CollectibleData(
    title: 'La Prison, à Chichen-Itza',
    wonder: WonderType.chichenItza,
    artifactId: '286467',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ph/web-large/DP132063.jpg',
    iconName: 'scroll',
  ),

// christRedeemer

// colosseum
  CollectibleData(
    title: 'Glass hexagonal amphoriskos',
    wonder: WonderType.colosseum,
    artifactId: '245376',
    imageUrl: 'https://images.metmuseum.org/CRDImages/gr/web-large/DP124005.jpg',
    iconName: 'vase',
  ),
  CollectibleData(
    title: 'Bronze plaque of Mithras slaying the bull',
    wonder: WonderType.colosseum,
    artifactId: '256570',
    imageUrl: 'https://images.metmuseum.org/CRDImages/gr/web-large/DP119236.jpg',
    iconName: 'camera',
  ),
  CollectibleData(
    title: 'Interno del Colosseo',
    wonder: WonderType.colosseum,
    artifactId: '286136',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ph/web-large/DP138036.jpg',
    iconName: 'jewelry',
  ),

// greatWall

// machuPicchu

// petra

// pyramidsGiza

// tajMahal
];

// Note: look up a human readable page with:
// https://www.metmuseum.org/art/collection/search/503940
// where 503940 is the ID.
