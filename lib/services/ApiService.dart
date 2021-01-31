import 'dart:convert';

import 'package:random_user/data/models/Post.dart';
import 'package:random_user/util/constants.dart';

import 'package:http/http.dart' as http;

class ApiService {
  final baseURL = Constants.API_HOST;

  Future<http.Response> _handleRequest(Future<http.Response> apiCall) async {
    http.Response apiResult;

    try {
      apiResult = await apiCall;
      return apiResult;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response> _get(
    String url, {
    auth = true,
    host,
    Map<String, String> header,
  }) async {
    host ??= baseURL;

    header ??= <String, String>{};

    header['Content-Type'] = "application/json";


    return await _handleRequest(http.get(host + url, headers: header),);
  }

  Future<http.Response> _put(
    String url, {
    dynamic body,
    host,
    Map<String, String> header,
  }) async {
    host ??= baseURL;

    header ??= <String, String>{};

    return await _handleRequest(
        http.put(
          host + url,
          body: body is Map ? json.encode(body) : body,
          headers: header,
        ),
    );
  }

  Future<http.Response> _patch(
    String url, {
    dynamic body,
    auth = true,
    host,
    Map<String, String> header,
  }) async {
    host ??= baseURL;

    header ??= <String, String>{};
    header['Content-Type'] = "application/json";

    return await _handleRequest(
        http.patch(
          host + url,
          body: body is Map ? json.encode(body) : body,
          headers: header,
        ));
  }

  Future<http.Response> _post(
    String url, {
    Map<String, dynamic> body,
    host,
    Map<String, String> header,
  }) async {
    host ??= baseURL;

    header ??= <String, String>{};

    header['Content-Type'] = "application/json";
    return await _handleRequest(http.post(host + url, body: json.encode(body), headers: header));
  }

  static bool isSuccessful(http.Response r, {bool bodyNotNull = true}) =>
      r != null && r.statusCode >= 200 && r.statusCode < 400 && (bodyNotNull ? r.body != null : true);


  Future<List<Post>> getPost() async {
    final http.Response res = await _get("/posts");

    if (!isSuccessful(res)) {
      throw(parseError(res));
    }

    final _listData = json.decode(res.body) as Iterable;

    return _listData.map((e) => Post.fromJson(e)).toList();
  }


  dynamic parseError(http.Response res) {
    dynamic error = res?.body;

    if (error == null) return null;

    try {
      final _errorMap = json.decode(error);
      error = _errorMap['messages']?.toString();
    } catch (e) {
      error = 'Error not known';
    }

    return error;
  }
}
