import 'dart:convert';
import 'dart:developer' as Dev;

import 'package:http/http.dart' as http;
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/utils/string_utils.dart';
import 'dart:developer' as Debug;

enum NetErrorType {
  none,
  disconnected,
  timedOut,
  denied,
}

enum MethodType { get, post, put, patch, delete, head }

typedef HttpRequest = Future<http.Response> Function();

class HttpClient {
  static const bool _logRequestUrlEnabled = false;
  static const bool _logRequestHeadersEnabled = false;
  static const bool _logRequestBodyEnabled = false;
  static const bool _logResponseUrlEnabled = false;
  static const bool _logResponseBodyEnabled = false;

  static Future<HttpResponse> get(String url, {Map<String, String>? headers}) async {
    debugPrint('------ GET ------');
    debugPrint(url);
    debugPrint(headers?.keys.toList().toString() ?? 'No keys');
    debugPrint(headers?.values.toList().toString() ?? 'No values');

    return await _request(() async {
      return await http.get(Uri.parse(url), headers: headers);
    });
  }

  static Future<HttpResponse> post(String url, {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    return await _request(() async {
      return await http.post(Uri.parse(url), headers: headers, body: body, encoding: encoding);
    });
  }

  static Future<HttpResponse> put(String url, {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    return await _request(() async {
      return await http.put(Uri.parse(url), headers: headers, body: body, encoding: encoding);
    });
  }

  static Future<HttpResponse> patch(String url,
      {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    return await _request(() async {
      return await http.patch(Uri.parse(url), headers: headers, body: body, encoding: encoding);
    });
  }

  static Future<HttpResponse> delete(String url, {Map<String, String>? headers}) async {
    return await _request(() async {
      return await http.delete(Uri.parse(url), headers: headers);
    });
  }

  static Future<HttpResponse> head(String url, {Map<String, String>? headers}) async {
    return await _request(() async {
      return await http.head(Uri.parse(url), headers: headers);
    });
  }

  static Future<HttpResponse> send(String url,
      {Map<String, dynamic>? urlParams,
      MethodType method = MethodType.get,
      Map<String, String>? headers,
      dynamic body,
      Encoding? encoding}) async {
    HttpResponse? response;
    int startMs = 0;

    if (urlParams != null) {
      Map<String, String> _urlParams = {};
      urlParams.forEach((String key, dynamic value) {
        _urlParams[key] = value.toString();
      });

      url += RESTUtils.encodeParams(_urlParams);
    }

    if (_logRequestUrlEnabled) {
      debugPrint('[HttpClient.send] $method $url');
    }
    if (_logRequestHeadersEnabled && headers != null && headers.toString() != '{}') {
      debugPrint('[HttpClient.send] headers: ${headers.toString()}');
    }
    if (_logRequestBodyEnabled && body != null) {
      debugPrint('[HttpClient.send] body: ${body.toString()}');
    }
    if (_logResponseUrlEnabled) {
      startMs = DateTime.now().millisecondsSinceEpoch;
    }

    switch (method) {
      case MethodType.get:
        response = await HttpClient.get(url, headers: headers);
        break;
      case MethodType.post:
        response = await HttpClient.post(url, headers: headers, body: body, encoding: encoding);
        break;
      case MethodType.put:
        response = await HttpClient.put(url, headers: headers, body: body, encoding: encoding);
        break;
      case MethodType.patch:
        response = await HttpClient.patch(url, headers: headers, body: body, encoding: encoding);
        break;
      case MethodType.delete:
        response = await HttpClient.delete(url, headers: headers);
        break;
      case MethodType.head:
        response = await HttpClient.head(url, headers: headers);
        break;
    }

    if (_logResponseUrlEnabled) {
      int msSince = DateTime.now().millisecondsSinceEpoch - startMs;
      Dev.log('>[HttpClient.send response] ${response.statusCode} ${msSince}ms url: $url');
    }
    if (_logResponseBodyEnabled) {
      Dev.log(">${response.body ?? "null"}");
    }

    return response;
  }

  static Future<HttpResponse> _request(HttpRequest request) async {
    http.Response response;
    try {
      response = await request();
    } on Exception catch (e) {
      debugPrint('Network call failed. error = ${e.toString()}');
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
        Debug.log('ParseError: ${e.message}');
      }
    }
  }
}
