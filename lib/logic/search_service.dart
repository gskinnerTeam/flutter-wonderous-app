import 'package:wonders/logic/utils/http_client.dart';
import 'dart:convert';

class SearchService {
  static String baseMETUrl = 'https://collectionapi.metmuseum.org';

  void init() {}

  Future<ServiceResult> getObjectIDList({DateTime? date, String? departmentIds}) async {
    HttpResponse response = await _request('public/collection/v1/objects', method: MethodType.get, urlParams: {
      'metadataDate': date, // in the format YYYY-MM-DD
      'departmentIds': departmentIds // use | as delimiter
    });
    return ServiceResult.fromResponse(response);
  }

  Future<ServiceResult> getDepartmentList() async {
    HttpResponse? response = await _request('public/collection/v1/departments', method: MethodType.get);
    return ServiceResult.fromResponse(response);
  }

  Future<ServiceResult> getObjectByID(int id) async {
    HttpResponse? response = await _request('public/collection/v1/objects/$id', method: MethodType.get);
    return ServiceResult.fromResponse(response);
  }

  Future<ServiceResult> searchForArtifacts(String query,
      {bool? isHighlight,
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

    HttpResponse response =
        await _request('public/collection/v1/objects', method: MethodType.get, urlParams: urlParams);
    return ServiceResult.fromResponse(response);
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
    urlParams = {};
    headers = {};

    String jsonBody = json.encode(body);

    HttpResponse? response = await HttpClient.send(url,
        urlParams: urlParams, method: method, headers: headers, body: jsonBody, encoding: encoding);

    return response;
  }
}
