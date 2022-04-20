import 'dart:math' as math;

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/data/department_data.dart';
import 'package:wonders/logic/search_service.dart';

class SearchLogic {
  final departmentList = ValueNotifier(<DepartmentData>[]);
  final Map<String, ArtifactData> _artifactHash = {};

  SearchService get service => GetIt.I.get<SearchService>();

  /// Return list of departments with titles and IDs.
  Future<void> getAllDepartments() async {
    departmentList.value = (await service.getDepartmentList()).content ?? [];
  }

  /// Return list of hashed artifact data.
  List<ArtifactData> get allLoadedArtifacts => _artifactHash.values.toList();

  /// Returns artifact data by ID. Returns null if artifact cannot be found. */
  Future<ArtifactData?> getArtifactByID(String id) async {
    ArtifactData? results;
    if (!_artifactHash.containsKey(id)) {
      // No data for artifact. Populate it for now and next time.
      results = (await service.getObjectByID(id)).content;
      if (results != null) {
        _artifactHash[id] = results;
      }
    } else {
      // Data is already stored. Use the reference instead of a server call.
      results = _artifactHash[id];
    }
    return results;
  }

  /// Returns multiple artifact data by ID list.*/
  Future<List<ArtifactData?>> getArtifactsByID(List<String> ids) async {
    List<ArtifactData?> results = [];
    ArtifactData? result;

    for (var id in ids) {
      if (!_artifactHash.containsKey(id)) {
        // No data for artifact. Populate it for now and next time.
        result = (await service.getObjectByID(id)).content;
        if (result != null) {
          _artifactHash[id] = result;
        }
      } else {
        // Data is already stored. Use the reference instead of a server call.
        result = _artifactHash[id];
      }
      if (result != null) {
        results.add(result);
      }
    }
    return results;
  }

  /// Returns list of artifact IDs by search query.
  /// - count; number of results to return
  /// - offset: offset the returned list of elements (used for multiple chunks of results)
  /// - isTitle: true if query is part of a title
  /// - isKeyword: true if query is part of a subject keyword
  /// - location: string of location names (cities, countries, etc). Multiple entries are separated by | operator.
  /// - startYear: minimum year range. Set to negative value for B.C. Must include endYear.
  /// - endYear: maximum year range. Set to negative value for B.C. Must include startYear.

  //TODO AG: Should make some sort of SearchConfig class here, so we don't need to pass a ton of params
  Future<List<ArtifactData?>> searchForArtifacts(String query,
      {int count = 1000,
      int offset = 0,
      bool? isTitle,
      bool? isKeyword,
      String? location,
      int? startYear,
      int? endYear}) async {
    final result = await service.searchForArtifacts(query,
        isTitle: isTitle, isKeywordTag: isKeyword, geoLocation: location, dateBegin: startYear, dateEnd: endYear);

    final ids = result.content ?? [];

    var futures = <Future<ArtifactData?>>[];
    int i = offset;
    int l = math.min(ids.length, offset + count);

    for (i; i < l; i++) {
      futures.add(getArtifactByID(ids[i]));
    }

    // Make all future calls simultaneously.
    final results = (await Future.wait<ArtifactData?>(futures));

    // Trim null results before returning.
    results.removeWhere((r) => r == null || r.image.isEmpty);
    return results;
  }
}
