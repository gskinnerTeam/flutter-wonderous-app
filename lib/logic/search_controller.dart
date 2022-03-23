import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/data/department_data.dart';
import 'package:wonders/logic/search_service.dart';
import 'dart:math' as math;

class SearchController {
  final departmentList = ValueNotifier(<DepartmentData>[]);
  final Map<int, ArtifactData> _artifactHash = {};

  SearchService get service => GetIt.I.get<SearchService>();

  /// Return list of departments with titles and IDs.
  Future<void> getAllDepartments() async {
    departmentList.value = (await service.getDepartmentList()).content ?? [];
  }

  /// Returns artifact data by ID. Returns null if artifact cannot be found. */
  Future<ArtifactData?> getArtifactByID(int id) async {
    ArtifactData? a;
    if (!_artifactHash.containsKey(id)) {
      // No data for artifact. Populate it for now and next time.
      a = (await service.getObjectByID(id)).content;
      if (a != null) {
        _artifactHash[id] = a;
      }
    } else {
      // Data is already stored. Use the reference instead of a server call.
      a = _artifactHash[id];
    }

    return a;
  }

  /// Returns list of artifact IDs by search query */
  Future<List<ArtifactData?>> searchForArtifacts(String query,
      {int count = 1000, int offset = 0, bool? isTitle, bool? isKeyword}) async {
    final result = await service.searchForArtifacts(
      query,
      isTitle: isTitle,
      isKeywordTag: isKeyword,
    );

    final ids = result.content ?? [];

    var futures = <Future<ArtifactData?>>[];
    int i = offset;
    int l = math.min(ids.length, offset + count);

    for (i; i < l; i++) {
      futures.add(getArtifactByID(ids[i]));
    }

    // Make all future calls simultaneously.
    final futureResults = (await Future.wait<ArtifactData?>(futures));

    // Trim null results before returning.
    futureResults.removeWhere((r) => r == null);
    return futureResults;
  }
}
