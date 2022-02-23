import 'dart:convert';
import 'dart:io';

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

  Future<String> _makeToken() async {
    final url = _makeUri(
      '/authentication/token/new',
      {'api_key': _apiKey},
    );
    // _client.connectionTimeout = Duration.zero;
    // для вызова ошибки таймаута
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final json = (await response.jsonDecode()) as Map<String, dynamic>;
      _validateResponse(response, json);
      final token = json['request_token'] as String;
      return token;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<String> _validateUser({
    required String userName,
    required String password,
    required String requestToken,
  }) async {
    try {
      final url = _makeUri(
          '/authentication/token/validate_with_login', {'api_key': _apiKey});
      final Map<String, dynamic> parameters = {
        'username': userName,
        'password': password,
        'request_token': requestToken
      };
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json; // стандартный хэдер
      request.write(jsonEncode(parameters)); // тело запроса
      final response = await request.close();
      final json = (await response.jsonDecode()) as Map<String, dynamic>;
      _validateResponse(response, json);
      final token = json['request_token'] as String;
      return token;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<String> _makeSession({required String requestToken}) async {
    try {
      final url = _makeUri('/authentication/session/new', {'api_key': _apiKey});
      final Map<String, dynamic> parameters = {'request_token': requestToken};
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json; // стандартный хэдер
      request.write(jsonEncode(parameters));
      final response = await request.close();
      final json = (await response.jsonDecode()) as Map<String, dynamic>;
      _validateResponse(response, json);
      final sessionId = json['session_id'] as String;
      return sessionId;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  void _validateResponse(HttpClientResponse response, Map<String, dynamic> json) {
    if (response.statusCode == 401){
      final status = json['status_code'];
      final code = status is int ? status : 0;
      if(code == 30) {
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
