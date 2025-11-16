import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:chiwi/http/response.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

class HttpRequester {
  static const DEFAULT_PORT = 8080;
  static const DEFAULT_HOST = "localhost";

  static Uri createUri({
    bool https = false,
    String? host,
    int? port,
    bool noPort = false,
    String path = "/",
    Map<String, dynamic>? queryParams,
  }) {
    host ??= DEFAULT_HOST;
    if (port == null || port < 0) {
      port = DEFAULT_PORT;
    }
    if (!noPort) {
      host += ":$port";
    }
    if (https)
      return Uri.https(host, path, queryParams);
    else
      return Uri.http(host, path, queryParams);
  }

  static Future<Response> get({
    required String path,
    bool https = false,
    String? host,
    int? port,
    bool noPort = false,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    Uri uri = createUri(
      https: https,
      host: host,
      port: port,
      noPort: noPort,
      path: path,
      queryParams: queryParams,
    );
    final client = BrowserClient()..withCredentials = true;
    http.Response httpResponse = await client.get(uri, headers: headers);
    client.close();
    Response response = getResponse(httpResponse);

    return Future.value(response);
  }

  static Future<Response> post({
    required String path,
    required Object body,
    bool https = false,
    String? host,
    int? port,
    bool noPort = false,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    Uri uri = createUri(
      https: https,
      host: host,
      port: port,
      noPort: noPort,
      path: path,
      queryParams: queryParams,
    );

    headers = headers ?? <String, String>{};
    dynamic requestBody;

    headers.putIfAbsent("Content-Type", () => "application/json");

    requestBody = body is Map<String, dynamic> ? jsonEncode(body) : body;

    final client = BrowserClient()..withCredentials = true;
    http.Response httpResponse = await client.post(
      uri,
      body: requestBody,
      headers: headers,
    );
    client.close();
    Response response = getResponse(httpResponse);

    return Future.value(response);
  }

  static Future<Response> postForm({
    required String path,
    Map<String, String>? fields,
    Map<String, Uint8List>? files,
    bool https = false,
    String? host,
    int? port,
    bool noPort = false,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    Uri uri = createUri(
      https: https,
      host: host,
      port: port,
      noPort: noPort,
      path: path,
      queryParams: queryParams,
    );

    headers = headers ?? <String, String>{};

    // TODO: See if this works
    final client = BrowserClient()..withCredentials = true;
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(headers);
    // await _addFields(request, fields!);
    await _addFiles(request, files!);
    var httpResponse = await client.send(request);
    client.close();

    Response response = await getResponseStreamed(httpResponse);

    return Future.value(response);
  }

  static Future<void> _addFields(
    http.MultipartRequest request,
    Map<String, String> fields,
  ) async {
    fields.forEach((field, value) async {
      request.fields[field] = value;
    });
  }

  static Future<void> _addFiles(
    http.MultipartRequest request,
    Map<String, Uint8List> files,
  ) async {
    files.forEach((field, bytes) async {
      request.files.add(
        await http.MultipartFile.fromBytes(field, bytes, filename: "shit.wav", contentType: .parse("audio/vnd.wav")),
      );
    });
  }

  static Future<Response> put({
    required String path,
    required Object body,
    bool https = false,
    String? host,
    int? port,
    bool noPort = false,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    Uri uri = createUri(
      https: https,
      host: host,
      port: port,
      noPort: noPort,
      path: path,
      queryParams: queryParams,
    );

    headers = headers ?? <String, String>{};
    dynamic requestBody;

    headers.putIfAbsent("Content-Type", () => "application/json");

    requestBody = body is Map<String, dynamic> ? jsonEncode(body) : body;

    final client = BrowserClient()..withCredentials = true;
    http.Response httpResponse = await client.put(
      uri,
      body: requestBody,
      headers: headers,
    );
    client.close();
    Response response = getResponse(httpResponse);

    return Future.value(response);
  }

  static Future<Response> delete({
    required String path,
    bool https = false,
    Object? body,
    String? host,
    int? port,
    bool noPort = false,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    Uri uri = createUri(
      https: https,
      host: host,
      port: port,
      noPort: noPort,
      path: path,
      queryParams: queryParams,
    );

    headers = headers ?? <String, String>{};
    dynamic requestBody;

    headers.putIfAbsent("Content-Type", () => "application/json");

    requestBody = body is Map<String, dynamic> ? jsonEncode(body) : body;

    final client = BrowserClient()..withCredentials = true;
    http.Response httpResponse = await client.delete(
      uri,
      body: requestBody,
      headers: headers,
    );
    client.close();
    Response response = getResponse(httpResponse);

    return Future.value(response);
  }

  static Response getResponse(http.Response httpResponse) {
    dynamic data;
    String? message;

    if (httpResponse.headers["content-type"] == "application/json") {
      Map<String, dynamic> responseBody = jsonDecode(httpResponse.body);
      data = responseBody["data"];
      message = responseBody["message"];
    } else {
      data = httpResponse.bodyBytes;
    }

    Response response = ResponseBuilder()
        .status(httpResponse.statusCode)
        .message(message ?? "no message")
        .data(data)
        .build();

    return response;
  }

  static Future<Response> getResponseStreamed(
    http.StreamedResponse httpResponse,
  ) async {
    dynamic data;
    String? message;

    List<int> bytes = List.empty(growable: true);
    var subs = httpResponse.stream.listen((data) {
      bytes.addAll(data);
    });

    await subs.asFuture(() {});

    Map<String, dynamic> responseBody = jsonDecode(utf8.decode(bytes));
    data = responseBody["data"];
    message = responseBody["message"];

    Response response = ResponseBuilder()
        .status(httpResponse.statusCode)
        .message(message ?? "no message")
        .data(data)
        .build();

    return response;
  }
}
