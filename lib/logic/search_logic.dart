import 'dart:math' as math;

import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/data/artifact_search_options.dart';
import 'package:wonders/logic/data/department_data.dart';
import 'package:wonders/logic/search_service.dart';

class SearchLogic {
  final departmentList = ValueNotifier(<DepartmentData>[]);
  SearchService get service => GetIt.I.get<SearchService>();

  final Map<String, ArtifactData> _artifactHash = {};
  ArtifactSearchOptions? _lastSearch;
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

  /// Returns list of artifact IDs by search query. ArtifactSearchOptions contains:
  /// - query; text query provided by the user
  /// - count; number of results to return
  /// - offset: offset the returned list of elements (used for multiple chunks of results)
  /// - isTitle: true if query is part of a title
  /// - isKeyword: true if query is part of a subject keyword
  /// - isHighlight: true if results should be labelled as MET highlights
  /// - departmentId: returns results from a specific department by ID
  /// - location: string of location names (cities, countries, etc). Multiple entries are separated by | operator.
  /// - startYear: minimum year range. Set to negative value for B.C. Must include endYear.
  /// - endYear: maximum year range. Set to negative value for B.C. Must include startYear.
  Future<List<ArtifactData?>> searchForArtifacts(ArtifactSearchOptions options) async {
    List<String> ids;

    if (options.query == _lastSearch?.query &&
        options.startYear == _lastSearch?.startYear &&
        options.endYear == _lastSearch?.endYear) {
      ids = _lastSearchResults;
    } else {
      final result = await service.searchForArtifacts(options);

      _lastSearch = options;
      ids = result.content ?? [];
      _lastSearchResults = ids;
    }

    var futures = <Future<ArtifactData?>>[];
    int i = options.offset;
    int l = math.min(ids.length, options.offset + options.count);

    for (; i < l; i++) {
      futures.add(getArtifactByID(ids[i]));
    }

    // Make all future calls simultaneously and trim the results.
    final results = _trimResults(await Future.wait<ArtifactData?>(futures));
    return results;
  }

  List<ArtifactData?> _trimResults(List<ArtifactData?> results) {
    // Trim null results to start.
    results.removeWhere((r) => r == null || r.image.isEmpty);

    // There exist some duplicate objects on the MET server that have differen ObjectIDs, but
    // use the same data otherwise. Use the image URLs to weed out doubles.
    List<String> jsonList = results.map((item) => item?.image ?? '').toList();
    jsonList = jsonList.toSet().toList();
    if (jsonList.length < results.length) {
      // Duplicates found!
      int test = 0;
      // This will go through the list in reverse order and search for the first instance of
      // an element with the same image URL as the tested one. If the result isn't equal
      // to i, we have an imposter, and it is removed.
      for (var i = results.length - 1; i >= 0; i--) {
        test = results.indexWhere((element) => element?.image == results[i]?.image);
        if (test != i) {
          // Remove the duplicate object from both search result IDs and actual.
          _lastSearchResults.remove(results[i]?.objectId);
          results.remove(results[i]);
        }
      }
    }
    return results;
  }
}
