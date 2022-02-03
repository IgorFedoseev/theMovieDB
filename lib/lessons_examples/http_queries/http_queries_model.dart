import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/lessons_examples/http_queries/domain/api_clients/api_client.dart';
import 'package:lazyload_flutter_course/lessons_examples/http_queries/domain/entity/post.dart';

class HttpExampleWidgetModel extends ChangeNotifier {
  final apiClient = ApiClient();
  var _posts = <Post>[];
  List<Post> get posts => _posts;

  Future<void> reloadPosts() async {
    final posts = await apiClient.getPosts();
    _posts += posts;
    notifyListeners();
  }

  Future<void> createPosts() async {
    await apiClient.createPost(title: 'title', body: 'body');
  }
}

class HttpExampleModelProvider
    extends InheritedNotifier<HttpExampleWidgetModel> {
  final HttpExampleWidgetModel model;
  const HttpExampleModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child, notifier: model);

  static HttpExampleModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<HttpExampleModelProvider>();
  }

  static HttpExampleModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<HttpExampleModelProvider>()
        ?.widget;
    return widget is HttpExampleModelProvider ? widget : null;
  }
}
