import 'dart:convert';
import 'dart:io';
import 'package:lazyload_flutter_course/lessons_examples/http_queries/domain/entity/post.dart';

class ApiClient {
  final client = HttpClient();

  // Future<List<Post>> getPosts() async {
  //   final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  //   // или так, что будет аналогично:
  //   // Uri(scheme: 'https', host: 'jsonplaceholder.typicode.com', path: 'posts');
  //   final request = await client.getUrl(url);
  //   final response = await request.close();
  //   // нам нужен 'dart:convert' чтобы
  //   // конвертировать стрим int (байтов) в стрим String
  //   final receivedData = await response.transform(utf8.decoder).toList();
  //   // у стрима toList() собирает все полученные данные в массив
  //   final jsonString = receivedData.join();
  //   final listOfData = jsonDecode(jsonString) as List<dynamic>;
  //   final posts = listOfData
  //       .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
  //       .toList();
  //   return posts;
  // }

  Future<List<Post>> getPosts() async {
    final json = await get('https://jsonplaceholder.typicode.com/posts');
    final listOfData = jsonDecode(json) as List<dynamic>;
    final posts = listOfData
        .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
    return posts;
  }

  Future<String> get(String uri) async {
    final url = Uri.parse(uri);
    final request = await client.getUrl(url);
    final response = await request.close();
    final receivedData = await response.transform(utf8.decoder).toList();
    final jsonString = receivedData.join();
    return jsonString;
  }
}
