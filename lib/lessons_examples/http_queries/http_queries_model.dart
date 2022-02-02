import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/lessons_examples/http_queries/domain/entity/post.dart';

class HttpExampleWidgetModel extends ChangeNotifier {
  var _posts = <Post>[];
  List<Post> get posts => _posts;
  void reloadPosts() {}
  void createPosts() {}
}

class HttpExampleModelProvider extends InheritedNotifier {
  final HttpExampleWidgetModel model;
  const HttpExampleModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

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
