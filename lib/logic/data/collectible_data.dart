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
    iconName: 'jewelry',
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
    iconName: 'picture',
  ),

  // christRedeemer
  CollectibleData(
    title: 'Engraved Horn',
    wonder: WonderType.christRedeemer,
    artifactId: '501302',
    imageUrl: 'https://images.metmuseum.org/CRDImages/mi/web-large/MUS550A2.jpg',
    iconName: 'statue',
  ),
  CollectibleData(
    title: 'Fixed fan',
    wonder: WonderType.christRedeemer,
    artifactId: '157985',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ci/web-large/48.60_front_CP4.jpg',
    iconName: 'jewelry',
  ),
  CollectibleData(
    title: 'Handkerchiefs (one of two)',
    wonder: WonderType.christRedeemer,
    artifactId: '227759',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ad/web-large/DP2896.jpg',
    iconName: 'textile',
  ),

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
    iconName: 'statue',
  ),
  CollectibleData(
    title: 'Interno del Colosseo',
    wonder: WonderType.colosseum,
    artifactId: '286136',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ph/web-large/DP138036.jpg',
    iconName: 'picture',
  ),

  // greatWall
  CollectibleData(
    title: 'Biographies of Lian Po and Lin Xiangru',
    wonder: WonderType.greatWall,
    artifactId: '39918',
    imageUrl: 'https://images.metmuseum.org/CRDImages/as/web-large/DP153769.jpg',
    iconName: 'scroll',
  ),
  CollectibleData(
    title: 'Jar with Dragon',
    wonder: WonderType.greatWall,
    artifactId: '39666',
    imageUrl: 'https://images.metmuseum.org/CRDImages/as/web-large/DT5083.jpg',
    iconName: 'vase',
  ),
  CollectibleData(
    title: 'Panel with Peonies and Butterfly',
    wonder: WonderType.greatWall,
    artifactId: '39735',
    imageUrl: 'https://images.metmuseum.org/CRDImages/as/web-large/DT834.jpg',
    iconName: 'textile',
  ),

  // machuPicchu
  CollectibleData(
    title: 'Eight-Pointed Star Tunic',
    wonder: WonderType.machuPicchu,
    artifactId: '308120',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/ra33.149.100.R.jpg',
    iconName: 'textile',
  ),
  CollectibleData(
    title: 'Camelid figurine',
    wonder: WonderType.machuPicchu,
    artifactId: '309960',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/DP-13440-031.jpg',
    iconName: 'statue',
  ),
  CollectibleData(
    title: 'Double Bowl',
    wonder: WonderType.machuPicchu,
    artifactId: '313341',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/web-large/DP104855.jpg',
    iconName: 'vase',
  ),

  // petra
  CollectibleData(
    title: 'Camel and riders',
    wonder: WonderType.petra,
    artifactId: '322592',
    imageUrl: 'https://images.metmuseum.org/CRDImages/an/web-large/DP-14352-001.jpg',
    iconName: 'statue',
  ),
  CollectibleData(
    title: 'Vessel',
    wonder: WonderType.petra,
    artifactId: '325918',
    imageUrl: 'https://images.metmuseum.org/CRDImages/an/web-large/hb67_246_37.jpg',
    iconName: 'vase',
  ),
  CollectibleData(
    title: 'Open bowl',
    wonder: WonderType.petra,
    artifactId: '326243',
    imageUrl: 'https://images.metmuseum.org/CRDImages/an/web-large/DT904.jpg',
    iconName: 'vase',
  ),

  // pyramidsGiza
  CollectibleData(
    title: 'Two papyrus fragments',
    wonder: WonderType.pyramidsGiza,
    artifactId: '546510',
    imageUrl: 'https://images.metmuseum.org/CRDImages/eg/web-large/09.180.537A_recto_0083.jpg',
    iconName: 'scroll',
  ),
  CollectibleData(
    title: 'Fragmentary Face of King Khafre',
    wonder: WonderType.pyramidsGiza,
    artifactId: '543896',
    imageUrl: 'https://images.metmuseum.org/CRDImages/eg/web-large/DT11751.jpg',
    iconName: 'statue',
  ),
  CollectibleData(
    title: 'Jewelry Elements',
    wonder: WonderType.pyramidsGiza,
    artifactId: '545728',
    imageUrl: 'https://images.metmuseum.org/CRDImages/eg/web-large/DP327402.jpg',
    iconName: 'jewelry',
  ),

  // tajMahal
  CollectibleData(
    title: 'Dagger with Scabbard',
    wonder: WonderType.tajMahal,
    artifactId: '24907',
    imageUrl: 'https://images.metmuseum.org/CRDImages/aa/web-large/DP157706.jpg',
    iconName: 'jewelry',
  ),
  CollectibleData(
    title: 'The House of Bijapur',
    wonder: WonderType.tajMahal,
    artifactId: '453183',
    imageUrl: 'https://images.metmuseum.org/CRDImages/is/web-large/DP231353.jpg',
    iconName: 'picture',
  ),
  CollectibleData(
    title: 'Panel of Nasta\'liq Calligraphy',
    wonder: WonderType.tajMahal,
    artifactId: '453983',
    imageUrl: 'https://images.metmuseum.org/CRDImages/is/web-large/DP299944.jpg',
    iconName: 'scroll',
  ),
];

// Note: look up a human readable page with:
// https://www.metmuseum.org/art/collection/search/503940
// where 503940 is the ID.
