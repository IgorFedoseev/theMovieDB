import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/library/widgets/inherited/provider.dart';
import 'package:lazyload_flutter_course/widgets/main_screen/main_screen_model.dart';
import 'package:lazyload_flutter_course/widgets/main_screen/main_screen_widget.dart';
import 'package:lazyload_flutter_course/widgets/movie_details/movie_details_model.dart';
import 'package:lazyload_flutter_course/widgets/movie_details/movie_details_widget.dart';
import 'package:lazyload_flutter_course/widgets/sign_in_page/sign_in_model.dart';
import 'package:lazyload_flutter_course/widgets/sign_in_page/sign_in_widget.dart';

abstract class MainNavigationRoutsNames {
  static const auth = 'sign_in';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRoutsNames.mainScreen
      : MainNavigationRoutsNames.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutsNames.auth: (context) =>
        NotifierProvider(create: () => SignInModel(), child: const SignInWidget()),
    MainNavigationRoutsNames.mainScreen: (context) => NotifierProvider(
        create: () => MainScreenModel(), child: const MainScreenWidget()),
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRoutsNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            create: () => MovieDetailsModel(movieId),
            child: const MovieDetailsWidget(),
          ),
        );
      default:
        const widget = Text('Ошибка навигации!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
