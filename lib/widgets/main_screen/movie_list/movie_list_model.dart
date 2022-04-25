import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lazyload_flutter_course/domain/api_client/api_client.dart';
import 'package:lazyload_flutter_course/domain/entity/movies.dart';
import 'package:lazyload_flutter_course/domain/entity/popular_movie_response.dart';
import 'package:lazyload_flutter_course/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  late int _currentPage;
  late int _totalPage;
  bool _isLoadingInProgress = false;
  String? _searchQuery;
  late DateFormat _dateFormat;
  List<Movie> get movies => List.unmodifiable(_movies);
  String _locale = '';
  Timer? searchDebounce;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if(_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _resetList();
  }

  Future<void> _resetList() async {
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    await _loadNextPage();
  }

  Future<PopularMovieResponse> _loadMovies(int nextPage, String region) async{
    final query = _searchQuery;
    if(query == null){
      return await _apiClient.popularMovies(nextPage, _locale);
    } else {
      return await _apiClient.searchMovies(nextPage, region, query);
    }
  }

  Future<void> _loadNextPage() async {
    if(_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true; // помечаем что данные грузятся
    final nextPage = _currentPage + 1;
    try{
      final moviesResponse = await _loadMovies(nextPage, _locale);
      _movies.addAll(moviesResponse.movies);
      _currentPage = moviesResponse.page;
      _totalPage = moviesResponse.totalPages;
      _isLoadingInProgress = false; // помечаем что данные загрузились
      notifyListeners();
    } catch (e){
      _isLoadingInProgress = false;
    }
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRoutsNames.movieDetails,
      arguments: id,
    );
  }

  Future<void> searchMovie(String text) async{
    searchDebounce?.cancel(); // отмена предыдущего таймера
    searchDebounce = Timer(const Duration(milliseconds: 500), () async{
      final searchQuery = text.isNotEmpty ? text : null;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;
      await _resetList();
    });
  }

  void showedMovieAtIndex(int index){
    if(index < _movies.length - 1) return;
      _loadNextPage();
  }
}
