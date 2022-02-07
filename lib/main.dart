import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/lessons_examples/shared_preference_and_security_storage_example/shared_security_example_widget.dart';
import 'package:lazyload_flutter_course/widgets/sign_in_page/sign_in_widget.dart';

import 'widgets/movie_details/movie_details_widget.dart';

void main() {
  runApp(const AppMovie());
}

class AppMovie extends StatelessWidget {
  const AppMovie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(3, 37, 65, 1),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(3, 37, 65, 1),
          selectedItemColor: Colors.tealAccent,
          unselectedItemColor: Colors.white,
        ),
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/sign_in': (context) => const SignInWidget(),
        '/main_screen': (context) =>
            const SharedSecurityExampleWidget(), //MainScreenWidget(), JsonMainExample()
        '/main_screen/movie_details': (context) {
          final argument = ModalRoute.of(context)?.settings.arguments;
          if (argument is int) {
            return MovieDetailsWidget(movieID: argument);
          } else {
            return const MovieDetailsWidget(movieID: 0);
          }
        }
      },
      initialRoute: '/sign_in',
    );
  }
}
