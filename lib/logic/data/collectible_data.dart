import 'package:wonders/common_libs.dart';

class CollectibleData {
  final String id;
  final String artifactId;
  final String title;
  final String desc;
  final String imageUrl;
  final ImageProvider sillhouette;
  bool collected; // todo: this should probably live somewhere else

  CollectibleData({
    required this.id,
    required this.artifactId,
    required this.title,
    required this.desc,
    required this.imageUrl,
    required this.sillhouette,
    this.collected = false,
  });
}

List<CollectibleData> collectibles = [
  CollectibleData(
    id: 'foo',
    title: 'Double Whistle',
    imageUrl: 'https://collectionapi.metmuseum.org/api/collection/v1/iiif/503940/1024225/main-image',
    desc: 'lorem ipsum',
    sillhouette: AssetImage('assets/images/collectibles/silhouette.png'),
    artifactId: '1',
  )
];
