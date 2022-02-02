import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/lessons_examples/http_queries/domain/entity/post.dart';

class HttpExampleWidgetModel extends ChangeNotifier {
  var _posts = <Post>[];
  List<Post> get posts => _posts;
}