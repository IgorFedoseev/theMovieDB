import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/library/widgets/inherited/provider.dart';
import 'package:lazyload_flutter_course/widgets/app/my_app.dart';
import 'package:lazyload_flutter_course/widgets/app/my_app_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = AppMovieModel();
  await model.checkAuth();
  const app = AppMovie();
  final mainWidget = Provider(model: model, child: app);
  runApp(mainWidget);
}


