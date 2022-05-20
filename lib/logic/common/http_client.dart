import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;
import 'package:wonders/logic/common/rest_utils.dart';
import 'package:wonders/logic/common/string_utils.dart';

enum NetErrorType {
  none,
  disconnected,
  timedOut,
  denied,
}

enum MethodType { get, post, put, patch, delete, head }

typedef HttpRequest = Future<http.Response> Function();

class HttpClient {
  static Future<HttpResponse> get(String url, {Map<String, String>? headers}) async {
    return await _request(() async {
      return await http.get(Uri.parse(url), headers: headers);
    });
  }

  static Future<HttpResponse> send(String url,
      {Map<String, dynamic>? urlParams,
      MethodType method = MethodType.get,
      Map<String, String>? headers,
      dynamic body,
      Encoding? encoding}) async {
    HttpResponse? response;

    if (urlParams != null) {
      Map<String, String> urlParams = {};
      urlParams.forEach((key, value) {
        urlParams[key] = value.toString();
      });

      url += RestUtils.encodeParams(urlParams);
    }

    response = await HttpClient.get(url, headers: headers);
    return response;
  }

  static Future<HttpResponse> _request(HttpRequest request) async {
    http.Response response;
    try {
      response = await request();
    } on Exception catch (e) {
      dev.log('Network call failed: ${e.toString()}');
      response = http.Response('ERROR: Could not get a response', 404);
    }
    return HttpResponse(response);
  }
}

class HttpResponse {
  final http.Response? raw;

  NetErrorType? errorType;

  bool get success => errorType == NetErrorType.none;

  String? get body => raw?.body;

  Map<String, String>? get headers => raw?.headers;

  int get statusCode => raw?.statusCode ?? -1;

  HttpResponse(this.raw) {
    //No response at all, there must have been a connection error
    if (raw == null) {
      errorType = NetErrorType.disconnected;
    } else if (raw!.statusCode >= 200 && raw!.statusCode <= 299) {
      errorType = NetErrorType.none;
    } else if (raw!.statusCode >= 500 && raw!.statusCode < 600) {
      errorType = NetErrorType.timedOut;
    } else if (raw!.statusCode >= 400 && raw!.statusCode < 500) {
      errorType = NetErrorType.denied;
    }
  }
}

class ServiceResult<R> {
  final HttpResponse response;

  R? content;

  bool get parseError => content == null;
  bool get success => response.success && !parseError;

  ServiceResult(this.response, R Function(Map<String, dynamic>) parser) {
    if (StringUtils.isNotEmpty(response.body) && response.success) {
      try {
        content = parser.call(jsonDecode(response.body!));
      } on FormatException catch (e) {
        dev.log('ParseError: ${e.message}');
      }
    }
  }
}
