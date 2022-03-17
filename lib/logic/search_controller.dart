import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/data/department_data.dart';
import 'package:wonders/logic/search_service.dart';
import 'package:wonders/logic/utils/http_client.dart';

class SearchController {
  List<int> artifactIDList = [];
  List<DepartmentData> departmentList = [];

  /// Return list of all artifact IDs.
  Future<void> getAllArtifactIDs() async {
    ServiceResult response = await GetIt.I.get<SearchService>().getObjectIDList();
    artifactIDList = _parseObjectIdsFromResponse(response);
  }

  /// Return list of departments with titles and IDs.
  Future<void> getAllDepartments() async {
    ServiceResult response = await GetIt.I.get<SearchService>().getDepartmentList();
    departmentList = _parseDepartmentsFromResponse(response);
  }

  /// Returns artifact data by ID. Returns null if artifact cannot be found. */
  Future<ArtifactData?> getArtifactByID(int id) async {
    ServiceResult response = await GetIt.I.get<SearchService>().getObjectByID(id);

    if (response is! ServiceError) {
      // Source: https://metmuseum.github.io/
      ArtifactData data = ArtifactData(
          title: response.content?['title'] ?? '',
          desc: (response.content?['culture'] ?? '') +
              ' ' +
              (response.content?['objectName'] ?? '') +
              ' - ' +
              (response.content?['period'] ?? ''),
          image: response.content?['primaryImage'] ?? '',
          year: int.parse(response.content?['accessionYear'] ?? ''));
      return data;
    }

    return null;
  }

  /// Returns list of artifact IDs by search query */
  Future<List<int>> searchForArtifactsByTitle(String query) async {
    ServiceResult response = await GetIt.I.get<SearchService>().searchForArtifacts(query, isTitle: true);
    return _parseObjectIdsFromResponse(response);
  }

  /// Returns list of artifact IDs by search query */
  Future<List<int>> searchForArtifactsByKeyword(String query) async {
    ServiceResult response = await GetIt.I.get<SearchService>().searchForArtifacts(query, isKeywordTag: true);
    return _parseObjectIdsFromResponse(response);
  }

  List<int> _parseObjectIdsFromResponse(ServiceResult response) {
    if (response is! ServiceError) {
      List<dynamic> idList = response.content?['objectIDs']?.toList();
      List<int> intList = idList.map((e) => e as int).toList();
      return intList;
    }
    return [];
  }

  List<DepartmentData> _parseDepartmentsFromResponse(ServiceResult response) {
    if (response is! ServiceError) {
      List<dynamic> idList = response.content?['departments']?.toList();
      List<DepartmentData> depList =
          idList.map((e) => DepartmentData(departmentId: e['departmentId'], displayName: e['displayName'])).toList();
      return depList;
    }
    return [];
  }
}
