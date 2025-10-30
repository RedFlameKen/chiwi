import 'dart:convert';

import 'package:chiwi/http/response.dart';
import 'package:http/http.dart' as http;

class HttpRequester {
  static const DEFAULT_PORT = 8080;
  static const DEFAULT_HOST = "localhost";

  static Uri createUri({
    String? host,
    int? port,
    String path = "/",
    Map<String, dynamic>? queryParams,
  }) {
    host ??= DEFAULT_HOST;
    if (port == null || port < 0) {
      port = DEFAULT_PORT;
    }
    host += ":$port";
    return Uri.http(host, path, queryParams);
  }

  static Future<Response> get({
    required String path,
    String? host,
    int? port,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    Uri uri = createUri(
      host: host,
      port: port,
      path: path,
      queryParams: queryParams,
    );
    http.Response httpResponse = await http.get(uri, headers: headers);
    Response response = getResponse(httpResponse);

    return Future.value(response);
  }

  static Future<Response> post({
    required String path,
    required Object body,
    String? host,
    int? port,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    Uri uri = createUri(
      host: host,
      port: port,
      path: path,
      queryParams: queryParams,
    );

    headers = headers ?? <String, String>{};
    dynamic requestBody;

    headers.putIfAbsent("Content-Type", () => "application/json");

    requestBody = body is Map<String, dynamic> ? jsonEncode(body) : body;

    http.Response httpResponse = await http.post(
      uri,
      body: requestBody,
      headers: headers,
    );
    Response response = getResponse(httpResponse);

    return Future.value(response);
  }

  static Future<Response> put({
    required String path,
    required Object body,
    String? host,
    int? port,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    Uri uri = createUri(
      host: host,
      port: port,
      path: path,
      queryParams: queryParams,
    );

    headers = headers ?? <String, String>{};
    dynamic requestBody;

    headers.putIfAbsent("Content-Type", () => "application/json");

    requestBody = body is Map<String, dynamic> ? jsonEncode(body) : body;

    http.Response httpResponse = await http.put(
      uri,
      body: requestBody,
      headers: headers,
    );
    Response response = getResponse(httpResponse);

    return Future.value(response);
  }

  static Future<Response> delete({
    required String path,
    required Object body,
    String? host,
    int? port,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    Uri uri = createUri(
      host: host,
      port: port,
      path: path,
      queryParams: queryParams,
    );

    headers = headers ?? <String, String>{};
    dynamic requestBody;

    headers.putIfAbsent("Content-Type", () => "application/json");

    requestBody = body is Map<String, dynamic> ? jsonEncode(body) : body;

    http.Response httpResponse = await http.delete(
      uri,
      body: requestBody,
      headers: headers,
    );
    Response response = getResponse(httpResponse);

    return Future.value(response);
  }

  static Response getResponse(http.Response httpResponse) {
    dynamic data;
    String? message;

    if (httpResponse.headers["Content-Type"] == "application/json") {
      Map<String, dynamic> responseBody = jsonDecode(httpResponse.body);
      data = responseBody["data"];
      message = responseBody["message"];
    } else {
      data = httpResponse.bodyBytes;
    }

    Response response = ResponseBuilder()
        .status(httpResponse.statusCode)
        .message(message ?? "")
        .data(data)
        .build();

    return response;
  }
}
