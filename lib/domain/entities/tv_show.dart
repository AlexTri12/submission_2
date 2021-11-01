import 'package:equatable/equatable.dart';

class TvShow extends Equatable {
  int id;
  String? title;
  String? posterPath;
  String? overview;
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  double? popularity;
  double? voteAverage;
  int? voteCount;

  TvShow({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
  });

  TvShow.watchlist({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    title,
    posterPath,
    overview,
    backdropPath,
    firstAirDate,
    genreIds,
    originCountry,
    originalLanguage,
    originalName,
    popularity,
    voteAverage,
    voteCount,
  ];
}