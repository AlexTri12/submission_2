import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_show_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvShow = TvShow(
    backdropPath: "/gIApbx2ffXVhJb2D4tiEx2b06nl.jpg",
    firstAirDate: "2005-03-27",
    genreIds: [18],
    id: 1416,
    title: "Grey's Anatomy",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Grey's Anatomy",
    overview: "Follows the personal and professional lives of a group of doctors at Seattle’s Grey Sloan Memorial Hospital.",
    popularity: 762.595,
    posterPath: "/zPIug5giU8oug6Xes5K1sTfQJxY.jpg",
    voteAverage: 8.2,
    voteCount: 6859
);

final testTvShowList = [testTvShow];

final testTvShowDetail = TvShowDetail(
    backdropPath: "/gIApbx2ffXVhJb2D4tiEx2b06nl.jpg",
    episodeRunTime: [43],
    genres: [
      Genre(
        id: 18,
        name: "Drama"
      )
    ],
    id: 1416,
    lastEpisodeToAir: Episode(
      airDate: "2021-10-14",
      episodeNumber: 3,
      id: 3178157,
      name: "Hotter Than Hell",
      overview: "Seattle’s favorite redhead returns and graces the Grey Sloan halls with her experience and expertise as she attempts to help Richard teach the newest crop of residents. Meanwhile, Meredith has a decision to make, and Link confides in Teddy",
      productionCode: "",
      seasonNumber: 18,
      stillPath: "/shAWv67Woqmj5WjSsXSATEDL2Lk.jpg",
      voteAverage: 0.0,
      voteCount: 0
    ),
    title: "Grey's Anatomy",
    nextEpisodeToAir: Episode(
      airDate: "2021-10-21",
      episodeNumber: 4,
      id: 3253623,
      name: "With a Little Help From My Friends",
      overview: "Richard recruits Meredith and Bailey to help him launch a new program. Meanwhile, Addison’s patient has complications from a procedure, and Jo helps a woman who goes into premature labor.",
      productionCode: "",
      seasonNumber: 18,
      stillPath: null,
      voteAverage: 0.0,
      voteCount: 0
    ),
    numberOfEpisodes: 383,
    numberOfSeasons: 18,
    originalTitle: "Grey's Anatomy",
    overview: "Follows the personal and professional lives of a group of doctors at Seattle’s Grey Sloan Memorial Hospital.",
    popularity: 762.595,
    posterPath: "/zPIug5giU8oug6Xes5K1sTfQJxY.jpg",
    seasons: [
      Season(
        airDate: null,
        episodeCount: 11,
        id: 3722,
        name: "Specials",
        overview: "",
        posterPath: "/snQYndfsEr3Sto2jOmkmsQuUXAQ.jpg",
        seasonNumber: 0
      )
    ],
    status: "Returning Series",
    voteAverage: 8.2,
    voteCount: 6861
);

final testWatchlistTvShow = TvShow.watchlist(
  id: 1416,
  title: "Grey's Anatomy",
  posterPath: "/zPIug5giU8oug6Xes5K1sTfQJxY.jpg",
  overview: "Follows the personal and professional lives of a group of doctors at Seattle’s Grey Sloan Memorial Hospital.",
);

final testTvShowTable = TvShowTable(
  id: 1416,
  title: "Grey's Anatomy",
  posterPath: "/zPIug5giU8oug6Xes5K1sTfQJxY.jpg",
  overview: "Follows the personal and professional lives of a group of doctors at Seattle’s Grey Sloan Memorial Hospital.",
);

final testTvShowMap = {
  'id': 1416,
  'title': "Grey's Anatomy",
  'posterPath': "/zPIug5giU8oug6Xes5K1sTfQJxY.jpg",
  'overview': "Follows the personal and professional lives of a group of doctors at Seattle’s Grey Sloan Memorial Hospital.",
};
