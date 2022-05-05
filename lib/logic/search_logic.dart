import 'dart:collection';

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/search_service.dart';

class SearchLogic {
  SearchService get service => GetIt.I.get<SearchService>();
  final HashMap<String, ArtifactData?> _artifactCache = HashMap();

  /// Returns artifact data by ID. Returns null if artifact cannot be found. */
  Future<ArtifactData?> getArtifactByID(String id) async {
    if (_artifactCache.containsKey(id)) return _artifactCache[id];
    ArtifactData? results = (await service.getObjectByID(id)).content;
    return _artifactCache[id] = results;
  }
}