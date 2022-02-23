
import 'package:json_annotation/json_annotation.dart';

part 'movies.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
// перевод полей из upperCamelCase в snake_case
class Movie {
  final String? posterPath;
  final bool adult;
  final String overview;
  final DateTime? releaseDate;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String? backdropPath;
  final double popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;

  Movie({
    this.posterPath,
    required this.adult,
    required this.overview,
    this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });
}
