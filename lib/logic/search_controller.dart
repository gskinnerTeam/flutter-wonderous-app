import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/data/department_data.dart';
import 'package:wonders/logic/search_service.dart';

class SearchController {
  List<DepartmentData>? departmentList;
  Map<int, ArtifactData> _artifactHash = {};

  SearchService get service => GetIt.I.get<SearchService>();

  /// Return list of departments with titles and IDs.
  Future<void> getAllDepartments() async {
    departmentList = (await service.getDepartmentList()).content ?? [];
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
  Future<List<ArtifactData>> searchForArtifacts(String query, {bool isTitle = false, bool isKeyword = false}) async {
    final result = await service.searchForArtifacts(
      query,
      isTitle: isTitle,
      isKeywordTag: isKeyword,
    );
    final ids = result.content ?? [];
    List<ArtifactData> data = [];
    for (var i = 0, l = ids.length; i < l; i++) {
      ArtifactData? a = await getArtifactByID(ids[i]);
      if (a != null) {
        data.add(a);
      }
    }
    return data;
  }
}
