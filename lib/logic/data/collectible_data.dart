import 'package:wonders/common_libs.dart';

class CollectibleData {
  CollectibleData({
    required this.id,
    required this.artifactId,
    required this.title,
    required this.desc,
    required this.period,
    required this.imageUrl,
    required this.icon,
    this.collected = false,
  });

  final String id;
  final String artifactId;
  final String title;
  final String desc;
  final String period;
  final String imageUrl;
  final ImageProvider icon;
  bool collected; // todo: this should probably live somewhere else
}

List<CollectibleData> collectibles = [
  CollectibleData(
    id: 'foo',
    title: 'Double Whistle',
    imageUrl: 'https://collectionapi.metmuseum.org/api/collection/v1/iiif/503940/1024225/main-image',
    desc: 'lorem ipsum',
    period: '7th-9th century',
    icon: AssetImage('${ImagePaths.collectibles}/silhouette.png'),
    artifactId: '1',
  )
];
