import 'package:wonders/logic/common/http_client.dart';
import 'package:wonders/logic/data/artifact_data.dart';

class MetAPIService {
  final String _baseMETUrl = 'https://collectionapi.metmuseum.org/public/collection/v1';

  Future<ServiceResult<ArtifactData?>> getObjectByID(String id) async {
    HttpResponse? response = await HttpClient.send('$_baseMETUrl/objects/$id');
    return ServiceResult<ArtifactData?>(response, _parseArtifactData);
  }

  ArtifactData? _parseArtifactData(Map<String, dynamic> content) {
    // Source: https://metmuseum.github.io/
    return ArtifactData(
      objectId: content['objectID'].toString(),
      title: content['title'] ?? '',
      image: content['primaryImage'] ?? '',
      date: content['objectDate'] ?? '',
      objectType: content['objectName'] ?? '',
      period: content['period'] ?? '',
      country: content['country'] ?? '',
      medium: content['medium'] ?? '',
      dimension: content['dimension'] ?? '',
      classification: content['classification'] ?? '',
      culture: content['culture'] ?? '',
      objectBeginYear: content['objectBeginDate'],
      objectEndYear: content['objectEndDate'],
    );
  }
}
