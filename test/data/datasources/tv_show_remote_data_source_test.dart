import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_show_remote_data_source.dart';
import 'package:ditonton/data/models/tv_show_detail_model.dart';
import 'package:ditonton/data/models/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvShowRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvShowRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Get Now Playing TV shows', () {
    final tTvShowList = TvShowResponse.fromJson(
        json.decode(readJson('dummy_data/tv_show_now_playing.json')))
        .tvShowList;

    test('Should return list of TV Show Model when the response code is 200', () async {
          // Arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async => http.Response(readJson('dummy_data/tv_show_now_playing.json'), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}));
          // Act
          final result = await dataSource.getNowPlayingTvShows();
          // Assert
          expect(result, equals(tTvShowList));
        });

    test('Should throw a ServerException when the response code is 404 or other', () async {
          // Arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // Act
          final call = dataSource.getNowPlayingTvShows();
          // Assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Get Popular TV shows', () {
    final tTvShowList =
        TvShowResponse.fromJson(json.decode(readJson('dummy_data/tv_show_popular.json')))
            .tvShowList;

    test('Should return list of TV Shows when response is success (200)', () async {
          // Arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response(readJson('dummy_data/tv_show_popular.json'), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}));
          // Act
          final result = await dataSource.getPopularTvShows();
          // Assert
          expect(result, tTvShowList);
        });

    test('Should throw a ServerException when the response code is 404 or other', () async {
          // Arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // Act
          final call = dataSource.getPopularTvShows();
          // Assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Get Top Rated TvShows', () {
    final tTvShowList = TvShowResponse.fromJson(
        json.decode(readJson('dummy_data/tv_show_top_rated.json')))
        .tvShowList;

    test('Should return list of TV Shows when response code is 200 ', () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tv_show_top_rated.json'), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}));
      // Act
      final result = await dataSource.getTopRatedTvShows();
      // Assert
      expect(result, tTvShowList);
    });

    test('Should throw ServerException when response code is other than 200',
            () async {
          // Arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // Act
          final call = dataSource.getTopRatedTvShows();
          // Assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Get TV Show detail', () {
    final tId = 1;
    final tTvShowDetail = TvShowDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_show_detail.json')));

    test('Should return TV Show detail when the response code is 200', () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tv_show_detail.json'), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}));
      // Act
      final result = await dataSource.getTvShowDetail(tId);
      // Assert
      expect(result, equals(tTvShowDetail));
    });

    test('Should throw Server Exception when the response code is 404 or other',
            () async {
          // Arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // Act
          final call = dataSource.getTvShowDetail(tId);
          // Assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Get TV Show recommendations', () {
    final tTvShowList = TvShowResponse.fromJson(
        json.decode(readJson('dummy_data/tv_show_recommendations.json')))
        .tvShowList;
    final tId = 1;

    test('Should return list of Tv Show Model when the response code is 200',
            () async {
          // Arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_show_recommendations.json'), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}));
          // Act
          final result = await dataSource.getTvShowRecommendations(tId);
          // Assert
          expect(result, equals(tTvShowList));
        });

    test('Should throw Server Exception when the response code is 404 or other',
            () async {
          // Arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // Act
          final call = dataSource.getTvShowRecommendations(tId);
          // Assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('Search tvShows', () {
    final tSearchResult = TvShowResponse.fromJson(
        json.decode(readJson('dummy_data/tv_show_search.json')))
        .tvShowList;
    final tQuery = 'Demon Slayer';

    test('Should return list of TV Shows when response code is 200', () async {
      // Arrange
      when(mockHttpClient
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy_data/tv_show_search.json'), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}));
      // Act
      final result = await dataSource.searchTvShows(tQuery);
      // Assert
      expect(result, tSearchResult);
    });

    test('Should throw ServerException when response code is other than 200',
            () async {
          // Arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // Act
          final call = dataSource.searchTvShows(tQuery);
          // Assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });
}
