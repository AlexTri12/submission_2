import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv_shows/data/models/genre_model.dart';
import 'package:tv_shows/data/models/tv_show_detail_model.dart';
import 'package:tv_shows/data/models/tv_show_model.dart';
import 'package:tv_shows/data/repositories/tv_show_repository_impl.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowRepositoryImpl repository;
  late MockTvShowRemoteDataSource mockRemoteDataSource;
  late MockTvShowLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvShowRemoteDataSource();
    mockLocalDataSource = MockTvShowLocalDataSource();
    repository = TvShowRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

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

  final tTvShowModelList = [tTvShowModel];
  final tTvShowList = [tTvShow];

  group('Now Playing Tv Shows', () {
    test(
        'Should return remote data when the call to remote data source is successful',
            () async {
          // Arrange
          when(mockRemoteDataSource.getNowPlayingTvShows())
              .thenAnswer((_) async => tTvShowModelList);
          // Act
          final result = await repository.getNowPlayingTvShows();
          // Assert
          verify(mockRemoteDataSource.getNowPlayingTvShows());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvShowList);
        });

    test(
        'Should return server failure when the call to remote data source is unsuccessful',
            () async {
          // Arrange
          when(mockRemoteDataSource.getNowPlayingTvShows())
              .thenThrow(ServerException());
          // Act
          final result = await repository.getNowPlayingTvShows();
          // Assert
          verify(mockRemoteDataSource.getNowPlayingTvShows());
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'Should return connection failure when the device is not connected to internet',
            () async {
          // Arrange
          when(mockRemoteDataSource.getNowPlayingTvShows())
              .thenThrow(SocketException('Failed to connect to the network'));
          // Act
          final result = await repository.getNowPlayingTvShows();
          // Assert
          verify(mockRemoteDataSource.getNowPlayingTvShows());
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Popular TV Shows', () {
    test('Should return TV Show list when call to data source is success',
            () async {
          // Arrange
          when(mockRemoteDataSource.getPopularTvShows())
              .thenAnswer((_) async => tTvShowModelList);
          // Act
          final result = await repository.getPopularTvShows();
          // Assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvShowList);
        });

    test(
        'Should return server failure when call to data source is unsuccessful',
            () async {
          // Arrange
          when(mockRemoteDataSource.getPopularTvShows())
              .thenThrow(ServerException());
          // Act
          final result = await repository.getPopularTvShows();
          // Assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'Should return connection failure when device is not connected to the internet',
            () async {
          // Arrange
          when(mockRemoteDataSource.getPopularTvShows())
              .thenThrow(SocketException('Failed to connect to the network'));
          // Act
          final result = await repository.getPopularTvShows();
          // Assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Top Rated Tv Shows', () {
    test('Should return TV Show list when call to data source is successful',
            () async {
          // Arrange
          when(mockRemoteDataSource.getTopRatedTvShows())
              .thenAnswer((_) async => tTvShowModelList);
          // Act
          final result = await repository.getTopRatedTvShows();
          // Assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvShowList);
        });

    test('Should return ServerFailure when call to data source is unsuccessful',
            () async {
          // Arrange
          when(mockRemoteDataSource.getTopRatedTvShows())
              .thenThrow(ServerException());
          // Act
          final result = await repository.getTopRatedTvShows();
          // Assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'Should return ConnectionFailure when device is not connected to the internet',
            () async {
          // Arrange
          when(mockRemoteDataSource.getTopRatedTvShows())
              .thenThrow(SocketException('Failed to connect to the network'));
          // Act
          final result = await repository.getTopRatedTvShows();
          // Assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Get Tv Show Detail', () {
    final tId = 1;
    final tTvShowResponse = TvShowDetailModel(
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

    test(
        'Should return Tv Show data when the call to remote data source is successful',
            () async {
          // Arrange
          when(mockRemoteDataSource.getTvShowDetail(tId))
              .thenAnswer((_) async => tTvShowResponse);
          // Act
          final result = await repository.getTvShowDetail(tId);
          // Assert
          verify(mockRemoteDataSource.getTvShowDetail(tId));
          expect(result, equals(Right(testTvShowDetail)));
        });

    test(
        'Should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // Arrange
          when(mockRemoteDataSource.getTvShowDetail(tId))
              .thenThrow(ServerException());
          // Act
          final result = await repository.getTvShowDetail(tId);
          // Assert
          verify(mockRemoteDataSource.getTvShowDetail(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'Should return connection failure when the device is not connected to internet',
            () async {
          // Arrange
          when(mockRemoteDataSource.getTvShowDetail(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // Act
          final result = await repository.getTvShowDetail(tId);
          // Assert
          verify(mockRemoteDataSource.getTvShowDetail(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get Tv Show Recommendations', () {
    final tTvShowList = <TvShowModel>[];
    final tId = 1;

    test('Should return data (TV Show list) when the call is successful',
            () async {
          // Arrange
          when(mockRemoteDataSource.getTvShowRecommendations(tId))
              .thenAnswer((_) async => tTvShowList);
          // Act
          final result = await repository.getTvShowRecommendations(tId);
          // Assert
          verify(mockRemoteDataSource.getTvShowRecommendations(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tTvShowList));
        });

    test(
        'Should return server failure when call to remote data source is unsuccessful',
            () async {
          // Arrange
          when(mockRemoteDataSource.getTvShowRecommendations(tId))
              .thenThrow(ServerException());
          // Act
          final result = await repository.getTvShowRecommendations(tId);
          // Assertbuild runner
          verify(mockRemoteDataSource.getTvShowRecommendations(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'Should return connection failure when the device is not connected to the internet',
            () async {
          // Arrange
          when(mockRemoteDataSource.getTvShowRecommendations(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // Act
          final result = await repository.getTvShowRecommendations(tId);
          // Assert
          verify(mockRemoteDataSource.getTvShowRecommendations(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Seach Tv Shows', () {
    final tQuery = 'Demon Slayer';

    test('Should return TV Show list when call to data source is successful',
            () async {
          // Arrange
          when(mockRemoteDataSource.searchTvShows(tQuery))
              .thenAnswer((_) async => tTvShowModelList);
          // Act
          final result = await repository.searchTvShows(tQuery);
          // Assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvShowList);
        });

    test('Should return ServerFailure when call to data source is unsuccessful',
            () async {
          // Arrange
          when(mockRemoteDataSource.searchTvShows(tQuery))
              .thenThrow(ServerException());
          // Act
          final result = await repository.searchTvShows(tQuery);
          // Assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'Should return ConnectionFailure when device is not connected to the internet',
            () async {
          // Arrange
          when(mockRemoteDataSource.searchTvShows(tQuery))
              .thenThrow(SocketException('Failed to connect to the network'));
          // Act
          final result = await repository.searchTvShows(tQuery);
          // Assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Save watchlist', () {
    test('Should return success message when saving successful', () async {
      // Arrange
      when(mockLocalDataSource.insertWatchlistTv(testTvShowTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // Act
      final result = await repository.saveTvWatchlist(testTvShowDetail);
      // Assert
      expect(result, Right('Added to Watchlist'));
    });

    test('Should return DatabaseFailure when saving unsuccessful', () async {
      // Arrange
      when(mockLocalDataSource.insertWatchlistTv(testTvShowTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // Act
      final result = await repository.saveTvWatchlist(testTvShowDetail);
      // Assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove watchlist', () {
    test('Should return success message when remove successful', () async {
      // Arrange
      when(mockLocalDataSource.removeWatchlistTv(testTvShowTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // Act
      final result = await repository.removeTvWatchlist(testTvShowDetail);
      // Assert
      expect(result, Right('Removed from watchlist'));
    });

    test('Should return DatabaseFailure when remove unsuccessful', () async {
      // Arrange
      when(mockLocalDataSource.removeWatchlistTv(testTvShowTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // Act
      final result = await repository.removeTvWatchlist(testTvShowDetail);
      // Assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get watchlist status', () {
    test('Should return watch status whether data is found', () async {
      // Arrange
      final tId = 1;
      when(mockLocalDataSource.getTvShowById(tId)).thenAnswer((_) async => null);
      // Act
      final result = await repository.isAddedToTvWatchlist(tId);
      // Assert
      expect(result, false);
    });
  });

  group('Get watchlist TV Shows', () {
    test('Should return list of TV Shows', () async {
      // Arrange
      when(mockLocalDataSource.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvShowTable]);
      // Act
      final result = await repository.getWatchlistTvShows();
      // Assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvShow]);
    });
  });
}