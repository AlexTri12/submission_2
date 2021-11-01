import 'package:tv_shows/data/models/genre_model.dart';
import 'package:tv_shows/domain/entities/genre.dart';
import 'package:tv_shows/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

class TvShowDetailModel extends Equatable {
  final String? backdropPath;
  final List<int> episodeRunTime;
  final String? firstAirDate;
  final List<GenreModel> genres;
  final String? homepage;
  final int id;
  final String? title;
  final bool inProduction;
  final List<String> languages;
  final String? lastAirDate;
  final EpisodeModel? lastEpisodeToAir;
  final EpisodeModel? nextEpisodeToAir;
  final List<NetworkModel>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<CompanyModel>? productionCompanies;
  final List<CountryModel>? productionCountries;
  final List<SeasonModel>? seasons;
  final List<LanguageModel>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  TvShowDetailModel({
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.title,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvShowDetailModel.fromJson(Map<String, dynamic> json) => TvShowDetailModel(
    backdropPath: json['backdrop_path'],
    episodeRunTime: List<int>.from(
      json['episode_run_time'].map((x) => x),
    ),
    firstAirDate: json['first_air_date'],
    genres: List<GenreModel>.from(
      json['genres'].map((x) => GenreModel.fromJson(x)),
    ),
    homepage: json['homepage'],
    id: json['id'],
    title: json['name'],
    inProduction: json['in_production'],
    languages: List<String>.from(
      json['languages'].map((x) => x),
    ),
    lastAirDate: json['last_air_date'],
    lastEpisodeToAir: json['next_episode_to_air'] == null ? null : EpisodeModel.fromJson(json['last_episode_to_air']),
    nextEpisodeToAir: json['next_episode_to_air'] == null ? null : EpisodeModel.fromJson(json['next_episode_to_air']),
    networks: List<NetworkModel>.from(
      json['networks'].map((x) => NetworkModel.fromJson(x)),
    ),
    numberOfEpisodes: json['number_of_episodes'],
    numberOfSeasons: json['number_of_seasons'],
    originCountry: List<String>.from(
      json['origin_country'].map((x) => x),
    ),
    originalName: json['original_name'],
    overview: json['overview'],
    popularity: json['popularity'].toDouble(),
    posterPath: json['poster_path'],
    productionCompanies: List<CompanyModel>.from(
      json['production_companies'].map((x) => CompanyModel.fromJson(x)),
    ),
    productionCountries: List<CountryModel>.from(
      json['production_countries'].map((x) => CountryModel.fromJson(x)),
    ),
    seasons: List<SeasonModel>.from(
      json['seasons'].map((x) => SeasonModel.fromJson(x)),
    ),
    spokenLanguages: List<LanguageModel>.from(
      json['spoken_languages'].map((x) => LanguageModel.fromJson(x)),
    ),
    status: json['status'],
    tagline: json['tagline'],
    type: json['type'],
    voteAverage: json['vote_average'].toDouble(),
    voteCount: json['vote_count'],
  );

  Map<String, dynamic> toJson() => {
    'backdrop_path': this.backdropPath,
    'episode_run_time': this.episodeRunTime,
    'first_air_date': this.firstAirDate,
    'genres': List<dynamic>.from(this.genres.map((x) => x.toJson())),
    'homepage': this.homepage,
    'id': this.id,
    'name': this.title,
    'in_production': this.inProduction,
    'languages': this.languages,
    'last_air_date': this.lastAirDate,
    'last_episode_to_air': this.lastEpisodeToAir!.toJson(),
    'next_episode_to_air': this.nextEpisodeToAir!.toJson(),
    'networks': List<dynamic>.from(this.networks!.map((x) => x.toJson())),
    'number_of_episodes': this.numberOfEpisodes,
    'number_of_seasons': this.numberOfSeasons,
    'origin_country': this.originCountry,
    'original_name': this.originalName,
    'overview': this.overview,
    'popularity': this.popularity,
    'poster_path': this.posterPath,
    'production_companies': List<dynamic>.from(this.productionCompanies!.map((x) => x.toJson())),
    'production_countries': List<dynamic>.from(this.productionCountries!.map((x) => x.toJson())),
    'seasons': List<dynamic>.from(this.seasons!.map((x) => x.toJson())),
    'spoken_languages': List<dynamic>.from(this.spokenLanguages!.map((x) => x.toJson())),
    'status': this.status,
    'tagline': this.tagline,
    'type': this.type,
    'vote_average': this.voteAverage,
    'vote_count': this.voteCount,
  };

  TvShowDetail toEntity() => TvShowDetail(
    id: this.id,
    title: this.title!,
    posterPath: this.posterPath!,
    overview: this.overview!,
    genres: List<Genre>.from(
      this.genres.map((x) => x.toEntity()),
    ),
    backdropPath: this.backdropPath,
    lastEpisodeToAir: this.lastEpisodeToAir == null ? null : this.lastEpisodeToAir!.toEntity(),
    nextEpisodeToAir: this.nextEpisodeToAir == null ? null : this.nextEpisodeToAir!.toEntity(),
    originalTitle: this.originalName,
    voteCount: this.voteCount,
    voteAverage: this.voteAverage,
    seasons: List<Season>.from(
      this.seasons!.map((x) => x.toEntity()),
    ),
    popularity: this.popularity,
    episodeRunTime: List<int>.from(
      this.episodeRunTime.map((x) => x),
    ),
    numberOfEpisodes: this.numberOfEpisodes,
    numberOfSeasons: this.numberOfSeasons,
    status: this.status,
  );

  @override
  List<Object?> get props => [
    backdropPath,
    episodeRunTime,
    firstAirDate,
    genres,
    homepage,
    id,
    title,
    inProduction,
    languages,
    lastAirDate,
    lastEpisodeToAir,
    nextEpisodeToAir,
    networks,
    numberOfEpisodes,
    numberOfSeasons,
    originCountry,
    originalName,
    overview,
    popularity,
    posterPath,
    productionCompanies,
    productionCountries,
    seasons,
    spokenLanguages,
    status,
    tagline,
    type,
    voteAverage,
    voteCount,
  ];
}

class EpisodeModel extends Equatable {
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

  EpisodeModel({
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

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
    airDate: json['air_date'],
    episodeNumber: json['episode_number'],
    id: json['id'],
    name: json['name'],
    overview: json['overview'],
    productionCode: json['production_code'],
    seasonNumber: json['season_number'],
    stillPath: json['still_path'],
    voteAverage: json['vote_average'].toDouble(),
    voteCount: json['vote_count'],
  );

  Map<String, dynamic> toJson() => {
    'air_date': this.airDate,
    'episode_number': this.episodeNumber,
    'id': this.id,
    'name': this.name,
    'overview': this.overview,
    'production_code': this.productionCode,
    'season_number': this.seasonNumber,
    'still_path': this.stillPath,
    'vote_average': this.voteAverage,
    'vote_count': this.voteCount,
  };

  Episode toEntity() => Episode(
    airDate: this.airDate,
    episodeNumber: this.episodeNumber,
    id: this.id,
    name: this.name,
    overview: this.overview,
    productionCode: this.productionCode,
    seasonNumber: this.seasonNumber,
    stillPath: this.stillPath,
    voteAverage: this.voteAverage,
    voteCount: this.voteCount,
  );

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

class NetworkModel extends Equatable {
  final String? name;
  final int id;
  final String? logoPath;
  final String? originCountry;

  NetworkModel({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
    name: json['name'],
    id: json['id'],
    logoPath: json['logo_path'],
    originCountry: json['origin_country'],
  );

  Map<String, dynamic> toJson() => {
    'name': this.name,
    'id': this.id,
    'logo_path': this.logoPath,
    'origin_country': this.originCountry,
  };

  @override
  List<Object?> get props => [name, id, logoPath, originCountry];
}

class CompanyModel extends Equatable {
  final String? name;
  final int id;
  final String? logoPath;
  final String? originCountry;

  CompanyModel({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    name: json['name'],
    id: json['id'],
    logoPath: json['logo_path'],
    originCountry: json['origin_country'],
  );

  Map<String, dynamic> toJson() => {
    'name': this.name,
    'id': this.id,
    'logo_path': this.logoPath,
    'origin_country': this.originCountry,
  };

  @override
  List<Object?> get props => [name, id, logoPath, originCountry];
}

class CountryModel extends Equatable {
  final String iso3166;
  final String name;

  CountryModel({required this.name, required this.iso3166});

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    iso3166: json['iso_3166_1'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'iso_3166_1': this.iso3166,
    'name': this.name,
  };

  @override
  List<Object?> get props => [iso3166, name];
}

class SeasonModel extends Equatable {
  final String? airDate;
  final int? episodeCount;
  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;

  SeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
    airDate: json['air_date'],
    episodeCount: json['episode_count'],
    id: json['id'],
    name: json['name'],
    overview: json['overview'],
    posterPath: json['poster_path'],
    seasonNumber: json['season_number'],
  );

  Map<String, dynamic> toJson() => {
    'air_date': this.airDate,
    'episode_count': this.episodeCount,
    'id': this.id,
    'name': this.name,
    'overview': this.overview,
    'poster_path': this.posterPath,
    'season_number': this.seasonNumber,
  };

  Season toEntity() => Season(
    airDate: this.airDate,
    episodeCount: this.episodeCount,
    id: this.id,
    name: this.name,
    overview: this.overview,
    posterPath: this.posterPath,
    seasonNumber: this.seasonNumber,
  );

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

class LanguageModel extends Equatable {
  final String englishName;
  final String iso639;
  final String name;

  LanguageModel({
    required this.englishName,
    required this.iso639,
    required this.name,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
    englishName: json['english_name'],
    iso639: json['iso_639_1'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'english_name': this.englishName,
    'iso_639_1': this.iso639,
    'name': this.name,
  };

  @override
  List<Object?> get props => [englishName, iso639, name];
}
