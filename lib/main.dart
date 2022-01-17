import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/example_textfield.dart';
import 'package:lazyload_flutter_course/widgets/main_screen/main_screen_widget.dart';
import 'package:lazyload_flutter_course/widgets/sign_in_page/sign_in_widget.dart';

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
        '/main_screen': (context) => const MainScreenWidget(), //MainScreenWidget(), const ExampleTextField(),
      },
      initialRoute: '/sign_in',
    );
  }
}

