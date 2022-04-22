import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/data/artifact_search_options.dart';
import 'package:wonders/logic/data/department_data.dart';
import 'package:wonders/logic/search_service.dart';
import 'dart:math' as math;

class SearchLogic {
  final departmentList = ValueNotifier(<DepartmentData>[]);
  SearchService get service => GetIt.I.get<SearchService>();

  final Map<String, ArtifactData> _artifactHash = {};
  String _lastSearchQuery = '';
  List<String> _lastSearchResults = [];

  /// Return a full count of the prior search results
  /// Note: this is separate from the hash, which collects across multiple searches.
  int get lastSearchResultCount => _lastSearchResults.length;

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

  /// Returns list of artifact IDs by search query.
  /// - count; number of results to return
  /// - offset: offset the returned list of elements (used for multiple chunks of results)
  /// - isTitle: true if query is part of a title
  /// - isKeyword: true if query is part of a subject keyword
  /// - location: string of location names (cities, countries, etc). Multiple entries are separated by | operator.
  /// - startYear: minimum year range. Set to negative value for B.C. Must include endYear.
  /// - endYear: maximum year range. Set to negative value for B.C. Must include startYear.

  //TODO AG: Should make some sort of SearchConfig class here, so we don't need to pass a ton of params
  Future<List<ArtifactData?>> searchForArtifacts(ArtifactSearchOptions options) async {
    List<String> ids;

    if (options.query == _lastSearchQuery) {
      ids = _lastSearchResults;
    } else {
      final result = await service.searchForArtifacts(options);

      _lastSearchQuery = options.query;
      ids = result.content ?? [];
      _lastSearchResults = ids;
    }

    var futures = <Future<ArtifactData?>>[];
    int i = options.offset;
    int l = math.min(ids.length, options.offset + options.count);

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
