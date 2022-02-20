import 'dart:convert';
import 'dart:io';

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '5ed3e0cc6ddcfd2b94b5515b08fc9119';

  Future<String> makeToken() async {
    final url = Uri.parse('$_host/authentication/token/new?api_key=$_apiKey');
    final request = await _client.getUrl(url);
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final token = json['request_token'] as String;
    return token;
  }

  Future<String> validateUser(
      {required String userName,
      required String password,
      required String requestToken}) async {
    final url = Uri.parse(
        '$_host/authentication/token/validate_with_login?api_key=$_apiKey');
    final Map<String, dynamic> parameters = {
      'username': userName,
      'password': password,
      'request_token': requestToken
    };
    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json; // стандартный хэдер
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final token = json['request_token'] as String;
    return token;
  }

  Future<String> makeSession({required String requestToken}) async {
    final url = Uri.parse(
        '$_host/authentication/session/new?api_key=$_apiKey');
    final Map<String, dynamic> parameters = {'request_token': requestToken};
    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json; // стандартный хэдер
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final sessionId = json['session_id'] as String;
    return sessionId;
  }
}
