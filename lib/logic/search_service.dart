import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:unsplash_client/unsplash_client.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/utils/platform_info.dart';
import 'package:wonders/logic/data/artifact_data.dart';
import 'package:wonders/logic/data/department_data.dart';
import 'package:wonders/logic/utils/http_client.dart';

class SearchService {
  static String baseMETUrl = 'https://collectionapi.metmuseum.org';

  Future<ServiceResult<List<String>?>> getObjectIDList({DateTime? date, String? departmentIds}) async {
    HttpResponse response = await _request('public/collection/v1/objects', urlParams: {
      'metadataDate': date, // in the format YYYY-MM-DD
      'departmentIds': departmentIds // use | as delimiter
    });
    return ServiceResult(response, _parseObjectIds);
  }

  Future<ServiceResult<List<DepartmentData>?>> getDepartmentList() async {
    HttpResponse? response = await _request('public/collection/v1/departments');
    return ServiceResult(response, _parseDepartmentData);
  }

  Future<ServiceResult<ArtifactData?>> getObjectByID(String id) async {
    HttpResponse? response = await _request('public/collection/v1/objects/$id');
    return ServiceResult(response, _parseArtifactData);
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
    return ServiceResult(response, _parseObjectIds);
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

    if (await PlatformInfo.isDisconnected) {
      return HttpResponse(null);
    }
    String jsonBody = json.encode(body);
    HttpResponse? response = await HttpClient.send(url,
        urlParams: urlParams, method: method, headers: headers, body: jsonBody, encoding: encoding);
    return response;
  }

  List<String>? _parseObjectIds(Map<String, dynamic> content) {
    List<dynamic> idList = (content['objectIDs'] ?? []).toList();
    return idList.map((e) => e.toString()).toList();
  }

  List<DepartmentData>? _parseDepartmentData(Map<String, dynamic> content) {
    List<dynamic> idList = (content['departments'] ?? []).toList();
    List<DepartmentData> result = idList.map((e) {
      return DepartmentData(
        departmentId: e['departmentId'],
        displayName: e['displayName'],
      );
    }).toList();
    return result;
  }

  ArtifactData? _parseArtifactData(Map<String, dynamic> content) {
    // Source: https://metmuseum.github.io/
    ArtifactData? data;
    try {
      String yearStr = content['accessionYear'] ?? content['objectDate'] ?? '';
      int year = 0;
      RegExpMatch? possibleYear = RegExp(r'[0-9-]{1,5}.*?').firstMatch(yearStr);
      if (possibleYear != null) {
        year = int.parse(possibleYear.input);
      }

      /// TODO: We should be able to use ArtifactData.fromJson here instead with some tweaks
      data = ArtifactData(
        objectId: content['objectID'],
        title: content['title'] ?? '',
        image: content['primaryImage'] ?? '',
        year: year,
        yearStr: yearStr,
        date: content['objectDate'] ?? '',
        objectType: content['objectName'] ?? '',
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

  Future<ServiceResult<List<String>?>> writeUniqueTypesToDisk({DateTime? date, String? departmentIds}) async {
    var result = await getObjectIDList(date: date, departmentIds: departmentIds);
    var allIds = result.content!;
    allIds.removeRange(0, 477500);
    final countsByType = <String, int>{};

    /// Loop through all ids in a set of chunks
    int chunkSize = 100;
    while (allIds.length > 1) {
      final ids = allIds.take(chunkSize);
      allIds.removeRange(0, min(chunkSize, allIds.length));
      final futures = <Future<ServiceResult<ArtifactData?>>>[];
      for (var id in ids) {
        futures.add(getObjectByID(id));
      }

      final results = await Future.wait(futures);
      for (var r in results) {
        final type = r.content!.objectType;
        if (r.content == null) continue;
        if (countsByType.containsKey(type) == false) {
          countsByType[type] = 0;
        }
        countsByType[type] = countsByType[type]! + 1;
      }
      print('Batch complete, ${allIds.length} remaining');
    }

    /// Write file
    final types = countsByType.keys.toList()..removeWhere((k) => countsByType[k]! <= 1);
    types.sort();
    var dir = await getApplicationDocumentsDirectory();
    var f = File('${dir.path}/artifact_types.csv');
    await f.writeAsString(types.join(','));
    print('file saved at: ${f.path}');
    return ServiceResult(result.response, (json) => []);
  }
}
