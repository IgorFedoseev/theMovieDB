import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lazyload_flutter_course/domain/api_client/api_client.dart';
import 'package:lazyload_flutter_course/domain/entity/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier{
  final _apiClient = ApiClient();

  final int movieId;
  MovieDetails? _movieDetails;
  late final String _locale;
  late DateFormat _dateFormat;

  MovieDetailsModel(this.movieId);

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if(_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await loadDetails();
  }

  Future<void> loadDetails() async{
    _movieDetails = await _apiClient.movieDetails(movieId, _locale);
    notifyListeners();
  }
}