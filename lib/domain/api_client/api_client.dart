import 'dart:convert';
import 'dart:io';

import 'package:lazyload_flutter_course/domain/entity/popular_movie_response.dart';

enum ApiClientExceptionType {
  network, // ошибка сети
  auth, // ошибка авторизации
  other, // прочее
}

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '5ed3e0cc6ddcfd2b94b5515b08fc9119';

  static String imageUrl(String path) => _imageUrl + path;

  Future<String> auth({
    required String userName,
    required String password,
  }) async {
    final token = await _makeToken();
    final validToken = await _validateUser(
      userName: userName,
      password: password,
      requestToken: token,
    );
    final sessionId = await _makeSession(requestToken: validToken);
    return sessionId;
  }

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> _get<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
  ]) async {
    final url = _makeUri(path, parameters);
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final json = (await response.jsonDecode());
      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<T> _post<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? bodyParameters,
  ]) async {
    final url = _makeUri(path, parameters);
    try {
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final json = (await response.jsonDecode());
      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<String> _makeToken() async {
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _get(
      '/authentication/token/new',
      parser,
      {'api_key': _apiKey},
    );
    return result;
  }

  Future<String> _validateUser({
    required String userName,
    required String password,
    required String requestToken,
  }) async {
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }
    final Map<String, dynamic> bodyParameters = {
      'username': userName,
      'password': password,
      'request_token': requestToken
    };
    final result = _post(
      '/authentication/token/validate_with_login',
      parser,
      {'api_key': _apiKey},
      bodyParameters,
    );
    return result;
  }

  Future<String> _makeSession({required String requestToken}) async {
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    }

    final Map<String, dynamic> parameters = {'request_token': requestToken};
    final result = _post(
      '/authentication/session/new',
      parser,
      {'api_key': _apiKey},
      parameters,
    );
    return result;
  }

  Future<PopularMovieResponse> popularMovies(int page, String region) async {
    PopularMovieResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/movie/popular',
      parser,
      {
        'api_key': _apiKey,
        'page': page.toString(),
        'language': region,
      },
    );
    return result;
  }

  Future<PopularMovieResponse> searchMovies(
    int page,
    String region,
    String query,
  ) async {
    PopularMovieResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }
    final result = _get(
      '/search/movie',
      parser,
      {
        'api_key': _apiKey,
        'page': page.toString(),
        'language': region,
        'query': query,
        'include_adult': true.toString(),
      },
    );
    return result;
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.auth);
      } else {
        throw ApiClientException(ApiClientExceptionType.other);
      }
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => json.decode(v));
  }
}
