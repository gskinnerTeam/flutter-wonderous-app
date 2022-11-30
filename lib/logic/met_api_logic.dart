import 'dart:collection';

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/common/http_client.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/met_api_service.dart';

class MetAPILogic {
  final HashMap<String, ArtifactData?> _artifactCache = HashMap();

  MetAPIService get service => GetIt.I.get<MetAPIService>();

  /// Returns artifact data by ID. Returns null if artifact cannot be found. */
  Future<ArtifactData?> getArtifactByID(String id) async {
    if (_artifactCache.containsKey(id)) return _artifactCache[id];
    ServiceResult<ArtifactData?> result = (await service.getObjectByID(id));
    if (!result.success) throw $strings.artifactDetailsErrorNotFound(id);
    ArtifactData? artifact = result.content;
    return _artifactCache[id] = artifact;
  }
}
