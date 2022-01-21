import 'package:flutter/material.dart';

import 'movie_details_main.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({Key? key, required this.movieID}) : super(key: key);

  final int movieID;

  @override
  _MovieDetailsWidgetState createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie info'),
      ),
      body: ColoredBox(
        color: const Color.fromRGBO(24, 23, 27, 0.95),
        child: ListView(
          children: const [
            MovieDetailsMainWidget(),
          ],
        ),
      ),
    );
  }
}