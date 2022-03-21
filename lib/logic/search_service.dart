import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/data/department_data.dart';
import 'package:wonders/logic/utils/http_client.dart';
import 'dart:convert';

class SearchService {
  static String baseMETUrl = 'https://collectionapi.metmuseum.org';

  void init() {}

  Future<ServiceResult<List<int>?>> getObjectIDList({DateTime? date, String? departmentIds}) async {
    HttpResponse response = await _request('public/collection/v1/objects', method: MethodType.get, urlParams: {
      'metadataDate': date, // in the format YYYY-MM-DD
      'departmentIds': departmentIds // use | as delimiter
    });
    return ServiceResult(response, _parseObjectIdsFromResponse);
  }

  Future<ServiceResult<List<DepartmentData>?>> getDepartmentList() async {
    HttpResponse? response = await _request('public/collection/v1/departments', method: MethodType.get);
    return ServiceResult(response, _parseDepartmentsFromResponse);
  }

  Future<ServiceResult<ArtifactData?>> getObjectByID(int id) async {
    HttpResponse? response = await _request('public/collection/v1/objects/$id', method: MethodType.get);
    return ServiceResult(response, _parseSearchResponse);
  }

  Future<ServiceResult<List<int>?>> searchForArtifacts(String query,
      {int count = 10,
      int offset = 0,
      bool? isHighlight,
      bool? isTitle,
      bool? isKeywordTag,
      int? departmentId,
      bool? isOnView,
      String? geoLocation,
      int? dateBegin,
      int? dateEnd}) async {
    Map<String, dynamic> urlParams = {};

    urlParams['q'] = query;
    urlParams['hasImages'] = true; // Must have images. That's a given.

    if (isHighlight != null) urlParams['isHighlight'] = isHighlight;
    if (isTitle != null) urlParams['title'] = isTitle;
    if (isKeywordTag != null) urlParams['tags'] = isKeywordTag;
    if (departmentId != null) urlParams['departmentId'] = departmentId;
    if (geoLocation != null) urlParams['geoLocation'] = geoLocation;

    // Years only as ints. Both dates must be used, if at all. Use negative numbers for B.C. and positive for A.D.
    if (dateBegin != null) urlParams['dateBegin'] = dateBegin;
    if (dateEnd != null) urlParams['dateEnd'] = dateEnd;

    HttpResponse response = await _request('public/collection/v1/search', method: MethodType.get, urlParams: urlParams);
    return ServiceResult(response, _parseObjectIdsFromResponse);
  }

  // ------------------------------------------------

  Future<HttpResponse> _request(
    String url, {
    MethodType method = MethodType.get,
    Map<String, dynamic>? urlParams,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Encoding? encoding,
  }) async {
    url = '$baseMETUrl/$url';
    urlParams ??= {};
    headers ??= {};

    String jsonBody = json.encode(body);

    HttpResponse? response = await HttpClient.send(url,
        urlParams: urlParams, method: method, headers: headers, body: jsonBody, encoding: encoding);

    return response;
  }

  List<int>? _parseObjectIdsFromResponse(Map<String, dynamic> content) {
    List<dynamic> idList = (content['objectIDs'] ?? []).toList();
    List<int> intList = idList.map((e) => e as int).toList();
    return intList;
  }

  List<DepartmentData>? _parseDepartmentsFromResponse(Map<String, dynamic> content) {
    List<dynamic> idList = (content['departments'] ?? []).toList();
    List<DepartmentData> depList =
        idList.map((e) => DepartmentData(departmentId: e['departmentId'], displayName: e['displayName'])).toList();
    return depList;
  }

  ArtifactData? _parseSearchResponse(Map<String, dynamic> content) {
    // Source: https://metmuseum.github.io/
    ArtifactData? data;
    try {
      data = ArtifactData(
          title: content['title'] ?? '',
          desc: (content['department'] ?? '') +
              ' ' +
              (content['objectName'] ?? '') +
              ' - ' +
              (content['repository'] ?? ''),
          image: content['primaryImage'] ?? '',
          year: content['accessionYear'] ?? content['objectDate'] ?? '');
    } catch (e) {
      var i = 0;
    }
    return data;
  }
}
