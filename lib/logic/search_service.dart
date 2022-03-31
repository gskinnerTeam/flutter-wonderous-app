import 'dart:convert';
import 'dart:developer' as dev;

import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/data/department_data.dart';
import 'package:wonders/logic/utils/http_client.dart';

class SearchService {
  static String baseMETUrl = 'https://collectionapi.metmuseum.org';

  Future<ServiceResult<List<String>?>> getObjectIDList({DateTime? date, String? departmentIds}) async {
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

  Future<ServiceResult<ArtifactData?>> getObjectByID(String id) async {
    HttpResponse? response = await _request('public/collection/v1/objects/$id', method: MethodType.get);
    return ServiceResult(response, _parseSearchResponse);
  }

  Future<ServiceResult<List<String>?>> searchForArtifacts(String query,
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

    // TODO: run a check for images with odd sizes. To do this:
    // - check the artifact's dimensions for multiple artifacts; see how often it relates to the image dimensions (should be at least a bit related)
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

    /* TODO: Check that there's an internet connection and return the appropriate result if there isn't.

    InternetConnectionStatus status = (await InternetConnectionChecker().connectionStatus);
    if (status == InternetConnectionStatus.disconnected) {
      setState(() {
        isDisconnected = true;
      });
      return;
    }
    */

    HttpResponse? response = await HttpClient.send(url,
        urlParams: urlParams, method: method, headers: headers, body: jsonBody, encoding: encoding);
    return response;
  }

  List<String>? _parseObjectIdsFromResponse(Map<String, dynamic> content) {
    List<dynamic> idList = (content['objectIDs'] ?? []).toList();
    return idList.map((e) => e as String).toList();
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
      String yearStr = content['accessionYear'] ?? content['objectDate'] ?? '';
      int year = 0;
      RegExpMatch? possibleYear = RegExp(r'[0-9-]{1,5}.*?').firstMatch(yearStr);
      if (possibleYear != null) {
        year = int.parse(possibleYear.input);
      }

      data = ArtifactData(
        objectId: content['objectID'],
        title: content['title'] ?? '',
        image: content['primaryImage'] ?? '',
        year: year,
        yearStr: yearStr,
        date: content['objectDate'] ?? '',
        period: content['period'] ?? '',
        country: content['country'] ?? '',
        medium: content['medium'] ?? '',
        dimension: content['dimension'] ?? '',
        classification: content['classification'] ?? '',
      );
    } catch (e) {
      dev.log('Error: Search response missing content.');
    }
    return data;
  }
}
