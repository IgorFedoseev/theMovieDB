import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lazyload_flutter_course/ui/navigation/main_navigation.dart';
import 'package:lazyload_flutter_course/widgets/app/my_app_model.dart';

class AppMovie extends StatelessWidget {
  final AppMovieModel model;
  static final mainNavigation = MainNavigation();
  const AppMovie({Key? key, required this.model}) : super(key: key);

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
      localizationsDelegates: const[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const[
        Locale('ru', 'RU'),
        Locale('en', ''),
      ],
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model.isAuth),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}