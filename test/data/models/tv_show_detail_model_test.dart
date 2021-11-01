import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_show_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/data/models/tv_show_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvShowDetailModel = TvShowDetailModel(
      backdropPath: "/gIApbx2ffXVhJb2D4tiEx2b06nl.jpg",
      episodeRunTime: [43],
      firstAirDate: "2005-03-27",
      genres: [
        GenreModel(
            id: 18,
            name: "Drama"
        )
      ],
      homepage: "http://abc.go.com/shows/greys-anatomy",
      id: 1416,
      inProduction: true,
      languages: ["en"],
      lastAirDate: "2021-10-14",
      lastEpisodeToAir: EpisodeModel(
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
      nextEpisodeToAir: EpisodeModel(
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
      networks: [
        NetworkModel(
          name: "ABC",
          id: 2,
          logoPath: "/ndAvF4JLsliGreX87jAc9GdjmJY.png",
          originCountry: "US",
        ),
      ],
      numberOfEpisodes: 383,
      numberOfSeasons: 18,
      originCountry: ["US"],
      originalName: "Grey's Anatomy",
      overview: "Follows the personal and professional lives of a group of doctors at Seattle’s Grey Sloan Memorial Hospital.",
      popularity: 762.595,
      posterPath: "/zPIug5giU8oug6Xes5K1sTfQJxY.jpg",
      productionCompanies: [
        CompanyModel(
          name: "The Mark Gordon Company",
          id: 1557,
          logoPath: "/ccz9bqCu3jSFKbPFnfWmjAKZLBL.png",
          originCountry: "US",
        ),
      ],
      productionCountries: [
        CountryModel(
          iso3166: "US",
          name: "United States of America",
        )
      ],
      seasons: [
        SeasonModel(
            airDate: null,
            episodeCount: 11,
            id: 3722,
            name: "Specials",
            overview: "",
            posterPath: "/snQYndfsEr3Sto2jOmkmsQuUXAQ.jpg",
            seasonNumber: 0
        )
      ],
      spokenLanguages: [
        LanguageModel(
          englishName: "English",
          iso639: "en",
          name: "English",
        )
      ],
      status: "Returning Series",
      tagline: "The life you save may be your own.",
      type: "Scripted",
      voteAverage: 8.2,
      voteCount: 6861
  );

  final tTvShowDetail = TvShowDetail(
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

  final tTvShowTable = TvShowTable(
    id: 1416,
    title: "Grey's Anatomy",
    posterPath: "/zPIug5giU8oug6Xes5K1sTfQJxY.jpg",
    overview: "Follows the personal and professional lives of a group of doctors at Seattle’s Grey Sloan Memorial Hospital.",
  );

  final tJson = {
    "backdrop_path": "/gIApbx2ffXVhJb2D4tiEx2b06nl.jpg",
    "episode_run_time": [
      43
    ],
    "first_air_date": "2005-03-27",
    "genres": [
      {
        "id": 18,
        "name": "Drama"
      }
    ],
    "homepage": "http://abc.go.com/shows/greys-anatomy",
    "id": 1416,
    "in_production": true,
    "languages": [
      "en"
    ],
    "last_air_date": "2021-10-14",
    "last_episode_to_air": {
      "air_date": "2021-10-14",
      "episode_number": 3,
      "id": 3178157,
      "name": "Hotter Than Hell",
      "overview": "Seattle’s favorite redhead returns and graces the Grey Sloan halls with her experience and expertise as she attempts to help Richard teach the newest crop of residents. Meanwhile, Meredith has a decision to make, and Link confides in Teddy",
      "production_code": "",
      "season_number": 18,
      "still_path": "/shAWv67Woqmj5WjSsXSATEDL2Lk.jpg",
      "vote_average": 0.0,
      "vote_count": 0
    },
    "name": "Grey's Anatomy",
    "next_episode_to_air": {
      "air_date": "2021-10-21",
      "episode_number": 4,
      "id": 3253623,
      "name": "With a Little Help From My Friends",
      "overview": "Richard recruits Meredith and Bailey to help him launch a new program. Meanwhile, Addison’s patient has complications from a procedure, and Jo helps a woman who goes into premature labor.",
      "production_code": "",
      "season_number": 18,
      "still_path": null,
      "vote_average": 0.0,
      "vote_count": 0
    },
    "networks": [
      {
        "name": "ABC",
        "id": 2,
        "logo_path": "/ndAvF4JLsliGreX87jAc9GdjmJY.png",
        "origin_country": "US"
      }
    ],
    "number_of_episodes": 383,
    "number_of_seasons": 18,
    "origin_country": [
      "US"
    ],
    "original_name": "Grey's Anatomy",
    "overview": "Follows the personal and professional lives of a group of doctors at Seattle’s Grey Sloan Memorial Hospital.",
    "popularity": 762.595,
    "poster_path": "/zPIug5giU8oug6Xes5K1sTfQJxY.jpg",
    "production_companies": [
      {
        "id": 1557,
        "logo_path": "/ccz9bqCu3jSFKbPFnfWmjAKZLBL.png",
        "name": "The Mark Gordon Company",
        "origin_country": "US"
      }
    ],
    "production_countries": [
      {
        "iso_3166_1": "US",
        "name": "United States of America"
      }
    ],
    "seasons": [
      {
        "air_date": null,
        "episode_count": 11,
        "id": 3722,
        "name": "Specials",
        "overview": "",
        "poster_path": "/snQYndfsEr3Sto2jOmkmsQuUXAQ.jpg",
        "season_number": 0
      }
    ],
    "spoken_languages": [
      {
        "english_name": "English",
        "iso_639_1": "en",
        "name": "English"
      }
    ],
    "status": "Returning Series",
    "tagline": "The life you save may be your own.",
    "type": "Scripted",
    "vote_average": 8.2,
    "vote_count": 6861
  };

  final tJsonTable = {
    "id": 1416,
    "title": "Grey's Anatomy",
    "overview": "Follows the personal and professional lives of a group of doctors at Seattle’s Grey Sloan Memorial Hospital.",
    "posterPath": "/zPIug5giU8oug6Xes5K1sTfQJxY.jpg",
  };

  test('Should be a subclass of TV Show Detail entity', () async {
    final result = tTvShowDetailModel.toEntity();
    expect(result, tTvShowDetail);
    expect(result.genres, tTvShowDetail.genres);
    expect(result.nextEpisodeToAir, tTvShowDetail.nextEpisodeToAir);
    expect(result.lastEpisodeToAir, tTvShowDetail.lastEpisodeToAir);
    expect(result.seasons, tTvShowDetail.seasons);
  });

  test('Should be able from TV show detail model to change to JSON', () async {
    final result = tTvShowDetailModel.toJson();
    expect(result, tJson);
  });

  test('Create TV show table from TV show detail', () async {
    final result = TvShowTable.fromEntity(tTvShowDetail);
    expect(result, tTvShowTable);
  });

  test('Should be able from TV show table to change to JSON', () async {
    final result = tTvShowTable.toJson();
    expect(result, tJsonTable);
  });
}
