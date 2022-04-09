
import 'package:wonders/common_libs.dart';

import 'artifact_data.dart';

class CollectibleData {
  final String id;
  final ArtifactData artifact;
  final ImageProvider sillhouette;
  bool collected; // todo: this should probably live somewhere else
  
  CollectibleData({
    required this.id,
    required this.artifact,
    required this.sillhouette,
    this.collected = false,
  });
}

// todo: this should probably come from a data file or similar, and live somewhere else:
List<CollectibleData> collectibles = [
  CollectibleData(
    id: 'foo',
    artifact: ArtifactData(
      title: 'Double Whistle',
      image: 'https://collectionapi.metmuseum.org/api/collection/v1/iiif/503940/1024225/main-image',
      desc: 'lorem ipsum',
      year: 2022,
    ),
    sillhouette: AssetImage('assets/images/collectibles/silhouette.png'),
  )
];
