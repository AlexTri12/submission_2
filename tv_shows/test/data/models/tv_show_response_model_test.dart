import 'dart:convert';

import 'package:tv_shows/data/models/tv_show_model.dart';
import 'package:tv_shows/data/models/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

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

  final tTvShowResponse = TvShowResponse(
    tvShowList: [tTvShowModel],
  );

  group('From JSON', () {
    test('Should return a valid model from JSON', () {
      // Arrange
      final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/tv_show_now_playing.json'));
      // Act
      final result = TvShowResponse.fromJson(jsonMap);
      // Assert
      expect(result, tTvShowResponse);
    });
  });

  group('To JSON', () {
    test('Should return a JSON map containing proper data', () {
      // Arrange
      final expectedJsonMap = {
        "results": [
          {
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
          }
        ]
      };
      // Act
      final result = tTvShowResponse.toJson();
      // Assert
      expect(result, expectedJsonMap);
    });
  });
}