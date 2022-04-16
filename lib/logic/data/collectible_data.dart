import 'package:wonders/common_libs.dart';

class CollectibleData {
  CollectibleData({
    required this.id,
    required this.artifactId,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.icon,
    this.collected = false,
  });

  final String id;
  final String artifactId;
  final String title;
  final String subtitle;
  final String imageUrl;
  final ImageProvider icon;
  bool collected; // todo: this should probably live somewhere else
}

List<CollectibleData> collectibles = [
  CollectibleData(
    id: 'foo',
    title: 'Double Whistle',
    subtitle: 'Mayan', // wonder culture
    imageUrl: 'https://collectionapi.metmuseum.org/api/collection/v1/iiif/503940/1024225/main-image',
    icon: AssetImage('${ImagePaths.collectibles}/silhouette.png'),
    artifactId: '1',
  )
];
