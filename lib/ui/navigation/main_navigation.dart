import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/widgets/main_screen/main_screen_widget.dart';
import 'package:lazyload_flutter_course/widgets/movie_details/movie_details_widget.dart';
import 'package:lazyload_flutter_course/widgets/sign_in_page/sign_in_model.dart';
import 'package:lazyload_flutter_course/widgets/sign_in_page/sign_in_widget.dart';

abstract class MainNavigationRoutsNames {
  static const auth = '/sign_in';
  static const mainScreen = '/main_screen';
  static const movieDetails = '/main_screen/movie_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRoutsNames.mainScreen
      : MainNavigationRoutsNames.auth;

  final routes = <String, Widget Function(BuildContext)>{
    '/sign_in': (context) =>
        SignInProvider(model: SignInModel(), child: const SignInWidget()),
    '/main_screen': (context) => const MainScreenWidget(),
    '/main_screen/movie_details': (context) {
      final argument = ModalRoute.of(context)?.settings.arguments;
      if (argument is int) {
        return MovieDetailsWidget(movieID: argument);
      } else {
        return const MovieDetailsWidget(movieID: 0);
      }
    },
  };
}
