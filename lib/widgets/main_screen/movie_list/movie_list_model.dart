import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/domain/api_client/api_client.dart';
import 'package:lazyload_flutter_course/domain/entity/movies.dart';
import 'package:lazyload_flutter_course/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  List<Movie> get movies => List.unmodifiable(_movies);

  Future<void> loadMovies() async {
    final moviesResponse = await _apiClient.popularMovies(1, 'ru-RU');
    _movies.addAll(moviesResponse.movies);
    notifyListeners();
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRoutsNames.movieDetails,
      arguments: id,
    );
  }
}
