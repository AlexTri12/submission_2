import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

class TvShowModel extends Equatable {
  final String? backdropPath;
  final String? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String title;
  final List<String> originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  TvShowModel({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.title,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvShowModel.fromJson(Map<String, dynamic> json) => TvShowModel(
    backdropPath: json['backdrop_path'],
    firstAirDate: json['first_air_date'],
    genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
    id: json['id'],
    title: json['name'],
    originCountry: List<String>.from(json['origin_country'].map((x) => x)),
    originalLanguage: json['original_language'],
    originalName: json['original_name'],
    overview: json['overview'],
    popularity: json['popularity'].toDouble(),
    posterPath: json['poster_path'],
    voteAverage: json['vote_average'].toDouble(),
    voteCount: json['vote_count'],
  );

  Map<String, dynamic> toJson() => {
    'backdrop_path': backdropPath,
    'first_air_date': firstAirDate,
    'genre_ids': List<dynamic>.from(genreIds.map((x) => x)),
    'id': id,
    'name': title,
    'origin_country': List<dynamic>.from(originCountry.map((x) => x)),
    'original_language': originalLanguage,
    'original_name': originalName,
    'overview': overview,
    'popularity': popularity,
    'poster_path': posterPath,
    'vote_average': voteAverage,
    'vote_count': voteCount,
  };

  TvShow toEntity() {
    return TvShow(
      id: this.id,
      title: this.title,
      posterPath: this.posterPath,
      overview: this.overview,
      backdropPath: this.backdropPath,
      firstAirDate: this.firstAirDate,
      genreIds: this.genreIds,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      popularity: this.popularity,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

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