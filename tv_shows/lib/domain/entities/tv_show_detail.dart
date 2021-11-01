import 'package:tv_shows/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvShowDetail extends Equatable {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final List<Genre> genres;
  final String? backdropPath;
  final String? originalTitle;
  final Episode? lastEpisodeToAir;
  final Episode? nextEpisodeToAir;
  final List<Season> seasons;
  final double? popularity;
  final double? voteAverage;
  final int? voteCount;
  final String? status;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<int> episodeRunTime;

  TvShowDetail({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.genres,
    required this.backdropPath,
    required this.lastEpisodeToAir,
    required this.nextEpisodeToAir,
    required this.originalTitle,
    required this.voteCount,
    required this.voteAverage,
    required this.seasons,
    required this.popularity,
    required this.episodeRunTime,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    posterPath,
    overview,
  ];
}

class Episode extends Equatable {
  final String? airDate;
  final int? episodeNumber;
  final int id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final int? seasonNumber;
  final String? stillPath;
  final double? voteAverage;
  final int? voteCount;

  Episode({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
    airDate,
    episodeNumber,
    id,
    name,
    overview,
    productionCode,
    seasonNumber,
    stillPath,
    voteAverage,
    voteCount,
  ];
}

class Season extends Equatable {
  final String? airDate;
  final int? episodeCount;
  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;

  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [
    airDate,
    episodeCount,
    id,
    name,
    overview,
    posterPath,
    seasonNumber,
  ];
}
