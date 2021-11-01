import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvShowModel = TvShowModel(
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

  final tTvShow = TvShow(
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

  final tJson = {
    "backdrop_path": "/gIApbx2ffXVhJb2D4tiEx2b06nl.jpg",
    "first_air_date": "2005-03-27",
    "genre_ids": [
      18
    ],
    "id": 1416,
    "name": "Grey's Anatomy",
    "origin_country": [
      "US"
    ],
    "original_language": "en",
    "original_name": "Grey's Anatomy",
    "overview": "Follows the personal and professional lives of a group of doctors at Seattle’s Grey Sloan Memorial Hospital.",
    "popularity": 762.595,
    "poster_path": "/zPIug5giU8oug6Xes5K1sTfQJxY.jpg",
    "vote_average": 8.2,
    "vote_count": 6859
  };

  test('Should be a subclass of TV Show entity', () async {
    final result = tTvShowModel.toEntity();
    expect(result, tTvShow);
  });

  test('Should be able from TV show model to change to JSON', () async {
    final result = tTvShowModel.toJson();
    expect(result, tJson);
  });
}
