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
    if (!_artifactHash.containsKey(id)) {
      // No data for artifact. Populate it for now and next time.
      ArtifactData? a = (await service.getObjectByID(id)).content;
      if (a != null) {
        _artifactHash[id] = a;
      }
    }

    return _artifactHash[id];
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
    var futureResults = (await Future.wait<ArtifactData?>(futures));
    return futureResults;
  }
}
