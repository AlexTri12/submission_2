import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_show_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/presentation/provider/tv_show_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendations,
  GetWatchlistTvShowStatus,
  SaveTvWatchlist,
  RemoveTvWatchlist,
])
void main() {
  late TvShowDetailNotifier provider;
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;
  late MockGetWatchlistTvShowStatus mockGetWatchlistTvShowStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;

    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    mockGetWatchlistTvShowStatus = MockGetWatchlistTvShowStatus();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    provider = TvShowDetailNotifier(
      getTvShowDetail:  mockGetTvShowDetail,
      getTvShowRecommendations: mockGetTvShowRecommendations,
      getWatchlistTvShowStatus: mockGetWatchlistTvShowStatus,
      removeTvWatchlist: mockRemoveTvWatchlist,
      saveTvWatchlist: mockSaveTvWatchlist,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tId = 1416;

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
  final tTvShows = [tTvShow];

  void _arrangeUseCase() {
    when(mockGetTvShowDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    when(mockGetTvShowRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvShows));
  }

  group('Get TV Show Detail', () {
    test('Should get data from the use case', () async {
      // Arrange
      _arrangeUseCase();
      // Act
      await provider.fetchTvShowDetail(tId);
      // Assert
      verify(mockGetTvShowDetail.execute(tId));
      verify(mockGetTvShowRecommendations.execute(tId));
    });

    test('Should change state to Loading when use case is called', () {
      // Arrange
      _arrangeUseCase();
      // Act
      provider.fetchTvShowDetail(tId);
      // Assert
      expect(provider.tvShowState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('Should change TV Show when data is gotten successfully', () async {
      // Arrange
      _arrangeUseCase();
      // Act
      await provider.fetchTvShowDetail(tId);
      // Assert
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.tvShow, testTvShowDetail);
      expect(listenerCallCount, 3);
    });

    test('Should change recommendation TV Shows when data is gotten successfully',
            () async {
          // Arrange
          _arrangeUseCase();
          // Act
          await provider.fetchTvShowDetail(tId);
          // Assert
          expect(provider.tvShowState, RequestState.Loaded);
          expect(provider.tvShowRecommendations, tTvShows);
        });
  });

  group('Get TV Show Recommendations', () {
    test('Should get data from the use case', () async {
      // Arrange
      _arrangeUseCase();
      // Act
      await provider.fetchTvShowDetail(tId);
      // Assert
      verify(mockGetTvShowRecommendations.execute(tId));
      expect(provider.tvShowRecommendations, tTvShows);
    });

    test('Should update recommendation state when data is gotten successfully',
            () async {
          // Arrange
          _arrangeUseCase();
          // Act
          await provider.fetchTvShowDetail(tId);
          // Assert
          expect(provider.recommendationState, RequestState.Loaded);
          expect(provider.tvShowRecommendations, tTvShows);
        });

    test('Should update error message when request in successful', () async {
      // Arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // Act
      await provider.fetchTvShowDetail(tId);
      // Assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('Should get the watchlist status', () async {
      // Arrange
      when(mockGetWatchlistTvShowStatus.execute(tId))
          .thenAnswer((_) async => true);
      // Act
      await provider.loadWatchlistStatus(tId);
      // Assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('Should execute save watchlist when function called', () async {
      // Arrange
      when(mockSaveTvWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      // Act
      await provider.addWatchlist(testTvShowDetail);
      // Assert
      verify(mockSaveTvWatchlist.execute(testTvShowDetail));
    });

    test('Should execute remove watchlist when function called', () async {
      // Arrange
      when(mockRemoveTvWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      // Act
      await provider.removeWatchlist(testTvShowDetail);
      // Assert
      verify(mockRemoveTvWatchlist.execute(testTvShowDetail));
    });

    test('Should update watchlist status when add watchlist success', () async {
      // Arrange
      when(mockSaveTvWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      // Act
      await provider.addWatchlist(testTvShowDetail);
      // Assert
      verify(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('Should update watchlist message when add watchlist failed', () async {
      // Arrange
      when(mockSaveTvWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      // Act
      await provider.addWatchlist(testTvShowDetail);
      // Assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('On Error', () {
    test('Should return error when data is unsuccessful', () async {
      // Arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvShows));
      // Act
      await provider.fetchTvShowDetail(tId);
      // Assert
      expect(provider.tvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}