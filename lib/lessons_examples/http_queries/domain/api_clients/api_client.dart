import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
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
    // Или так:  final url = Uri(scheme: 'https', host: 'jsonplaceholder.typicode.com', path: 'posts');
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
    // if(response.statusCode == 200) - можно добавить условия что всё ОК
    final receivedData = await response.transform(utf8.decoder).toList();
    final jsonString = receivedData.join();
    return jsonString;
  }

  Future<Post?> createPost(
      {required String title, required String body}) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final parameters = <String, dynamic>{
      'title': title,
      'body': body,
      'userId': 109
    };
    final request = await client.postUrl(url);
    request.headers.set('Content-type', 'application/json; charset=UTF-8');
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final receivedData = await response.transform(utf8.decoder).toList();
    final jsonString = receivedData.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final post = Post.fromJson(json);
    return post;
  }

  Future<void> fileUpload(File file) async {
    final url = Uri.parse('https://example.com');
    final request = await client.postUrl(url);
    request.headers.set(HttpHeaders.contentTypeHeader, ContentType.binary);
    request.headers.add('filename', basename(file.path));
    request.contentLength = file.lengthSync();
    final fileStream = file.openRead();
    await request.addStream(fileStream);
    final httpResponse = await request.close();

    if (httpResponse.statusCode != 200) {
      throw Exception('Error uploading file');
    } else {
      return;
    }
  }
}
