import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_shows_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_shows_notifier_test.mocks.dart';

@GenerateMocks([
  GetTopRatedTvShows,
])
void main() {
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;
  late TopRatedTvShowsNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    provider = TopRatedTvShowsNotifier(
        getTopRatedTvShows: mockGetTopRatedTvShows
    )
      ..addListener(() {
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

  test('Should change state to loading when use case is called', () async {
    // Arrange
    when(mockGetTopRatedTvShows.execute())
        .thenAnswer((_) async => Right(tTvShowList));
    // Act
    provider.fetchTopRatedTvShows();
    // Assert
    expect(provider.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test(
      'Should change TV Shows data when data is gotten successfully', () async {
    // Arrange
    when(mockGetTopRatedTvShows.execute())
        .thenAnswer((_) async => Right(tTvShowList));
    // Act
    await provider.fetchTopRatedTvShows();
    // Assert
    expect(provider.state, RequestState.Loaded);
    expect(provider.tvShows, tTvShowList);
    expect(listenerCallCount, 2);
  });

  test('Should return error when data is unsuccessful', () async {
    // Arrange
    when(mockGetTopRatedTvShows.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // Act
    await provider.fetchTopRatedTvShows();
    // Assert
    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}