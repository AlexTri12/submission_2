
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_shows.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:ditonton/presentation/provider/tv_show_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvShows,
  GetPopularTvShows,
  GetTopRatedTvShows,
])
void main() {
  late TvShowListNotifier provider;
  late MockGetNowPlayingTvShows mockGetNowPlayingTvShows;
  late MockGetPopularTvShows mockGetPopularTvShows;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvShows = MockGetNowPlayingTvShows();
    mockGetPopularTvShows = MockGetPopularTvShows();
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    provider = TvShowListNotifier(
      getNowPlayingTvShows: mockGetNowPlayingTvShows,
      getPopularTvShows: mockGetPopularTvShows,
      getTopRatedTvShows: mockGetTopRatedTvShows,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

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
  final tTvShowList = [tTvShow];

  group('Now playing TV Shows', () {
    test('InitialState Should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('Should get data from the use case', () async {
      // Arrange
      when(mockGetNowPlayingTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // Act
      provider.fetchNowPlayingTvShows();
      // Assert
      verify(mockGetNowPlayingTvShows.execute());
    });

    test('Should change state to Loading when use case is called', () {
      // Arrange
      when(mockGetNowPlayingTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // Act
      provider.fetchNowPlayingTvShows();
      // Assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('Should change TV Shows when data is gotten successfully', () async {
      // Arrange
      when(mockGetNowPlayingTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // Act
      await provider.fetchNowPlayingTvShows();
      // Assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('Should return error when data is unsuccessful', () async {
      // Arrange
      when(mockGetNowPlayingTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // Act
      await provider.fetchNowPlayingTvShows();
      // Assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Popular TV Shows', () {
    test('Should change state to loading when use case is called', () async {
      // Arrange
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // Act
      provider.fetchPopularTvShows();
      // Assert
      expect(provider.popularTvShowsState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('Should change TV Shows data when data is gotten successfully',
            () async {
          // Arrange
          when(mockGetPopularTvShows.execute())
              .thenAnswer((_) async => Right(tTvShowList));
          // Act
          await provider.fetchPopularTvShows();
          // Assert
          expect(provider.popularTvShowsState, RequestState.Loaded);
          expect(provider.popularTvShows, tTvShowList);
          expect(listenerCallCount, 2);
        });

    test('Should return error when data is unsuccessful', () async {
      // Arrange
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // Act
      await provider.fetchPopularTvShows();
      // Assert
      expect(provider.popularTvShowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Top rated TV Shows', () {
    test('Should change state to loading when use case is called', () async {
      // Arrange
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      // Act
      provider.fetchTopRatedTvShows();
      // Assert
      expect(provider.topRatedTvShowsState, RequestState.Loading);
    });

    test('Should change TV Shows data when data is gotten successfully',
            () async {
          // Arrange
          when(mockGetTopRatedTvShows.execute())
              .thenAnswer((_) async => Right(tTvShowList));
          // Act
          await provider.fetchTopRatedTvShows();
          // Assert
          expect(provider.topRatedTvShowsState, RequestState.Loaded);
          expect(provider.topRatedTvShows, tTvShowList);
          expect(listenerCallCount, 2);
        });

    test('Should return error when data is unsuccessful', () async {
      // Arrange
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // Act
      await provider.fetchTopRatedTvShows();
      // Assert
      expect(provider.topRatedTvShowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}