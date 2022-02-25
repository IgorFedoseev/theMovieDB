import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lazyload_flutter_course/domain/api_client/api_client.dart';
import 'package:lazyload_flutter_course/domain/entity/movies.dart';
import 'package:lazyload_flutter_course/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  late int _currentPage;
  late int _totalPage;
  bool _isLoadingInProgress = false;
  late DateFormat _dateFormat;
  List<Movie> get movies => List.unmodifiable(_movies);
  String _locale = '';

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  void setupLocale(BuildContext context){
    final locale = Localizations.localeOf(context).toLanguageTag();
    if(_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    if(_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    final nextPage = _currentPage + 1;
    final moviesResponse = await _apiClient.popularMovies(nextPage, _locale);
    _movies.addAll(moviesResponse.movies);
    _currentPage = moviesResponse.page;
    _totalPage = moviesResponse.totalPages;
    _isLoadingInProgress = false;
    notifyListeners();
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRoutsNames.movieDetails,
      arguments: id,
    );
  }

  void showedMovieAtIndex(int index){
    if(index < _movies.length - 1) return;
      _loadMovies();

  }
}
