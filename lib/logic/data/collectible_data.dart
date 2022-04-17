import 'package:wonders/common_libs.dart';

class CollectibleData {
  CollectibleData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.icon,
    required this.artifactId,
    required this.wonder,
  });

  String get id => artifactId;
  final String title;
  final String subtitle; // this should come from WonderData.artifactCulture
  final String imageUrl;
  final ImageProvider icon;

  final String artifactId;
  final WonderType wonder;
}

List<CollectibleData> collectibles = [
  // chichenItza
  CollectibleData(
    title: 'La Prison, à Chichen-Itza',
    subtitle: 'Mayan',
    wonder: WonderType.chichenItza,
    artifactId: '286467',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ph/original/DP132063.jpg',
    icon: AssetImage('${ImagePaths.collectibles}/silhouette.png'),
  ),
  CollectibleData(
    title: 'Pendant',
    subtitle: 'Mayan',
    wonder: WonderType.chichenItza,
    artifactId: '701645',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/original/DP701440.jpg',
    icon: AssetImage('${ImagePaths.collectibles}/silhouette.png'),
  ),
  CollectibleData(
    title: 'Bird Ornament',
    subtitle: 'Mayan',
    wonder: WonderType.chichenItza,
    artifactId: '310555',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ao/original/DP-23474-001.jpg',
    icon: AssetImage('${ImagePaths.collectibles}/foo.png'),
  ),

  // christRedeemer

  // colosseum
  CollectibleData(
    title: 'Glass hexagonal amphoriskos',
    subtitle: 'Roman',
    wonder: WonderType.colosseum,
    artifactId: '245376',
    imageUrl: 'https://images.metmuseum.org/CRDImages/gr/original/DP124005.jpg',
    icon: AssetImage('${ImagePaths.collectibles}/foo.png'),
  ),
  CollectibleData(
    title: 'Bronze plaque of Mithras slaying the bull',
    subtitle: 'Roman',
    wonder: WonderType.colosseum,
    artifactId: '256570',
    imageUrl: 'https://images.metmuseum.org/CRDImages/gr/original/DP119236.jpg',
    icon: AssetImage('${ImagePaths.collectibles}/silhouette.png'),
  ),
  CollectibleData(
    title: 'Interno del Colosseo',
    subtitle: 'Roman',
    wonder: WonderType.colosseum,
    artifactId: '286136',
    imageUrl: 'https://images.metmuseum.org/CRDImages/ph/original/DP138036.jpg',
    icon: AssetImage('${ImagePaths.collectibles}/foo.png'),
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
