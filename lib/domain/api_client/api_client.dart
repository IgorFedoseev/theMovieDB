import 'dart:convert';
import 'dart:io';

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '5ed3e0cc6ddcfd2b94b5515b08fc9119';

  Future <String> makeToken() async{
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



  // Future<List<Post>> getPost() async {
  //   final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  //   final request = await _client.getUrl(url);
  //   final response = await request.close();
  //   final json = await response
  //       .transform(utf8.decoder)
  //       .toList()
  //       .then((value) => value.join())
  //       .then((v) => jsonDecode(v) as List<dynamic>);
  //   final result = json.map((dynamic e) => Post.fromJson(e as Map<String,dynamic>)).toList();
  //   return result;
  // }


}
