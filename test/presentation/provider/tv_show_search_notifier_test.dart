import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/search_tv_shows.dart';
import 'package:ditonton/presentation/provider/tv_show_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_search_notifier_test.mocks.dart';

@GenerateMocks([
  SearchTvShows,
])
void main() {
  late TvShowSearchNotifier provider;
  late MockSearchTvShows mockSearchTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvShows = MockSearchTvShows();
    provider = TvShowSearchNotifier(
      searchTvShows: mockSearchTvShows
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
  final tQuery = "Grey's Anatomy";

  group('Search TV Shows', () {
    test('Should change state to loading when use case is called', () async {
      // Arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      // Act
      provider.fetchTvShowSearch(tQuery);
      // Assert
      expect(provider.state, RequestState.Loading);
    });

    test('Should change search result data when data is gotten successfully',
            () async {
          // Arrange
          when(mockSearchTvShows.execute(tQuery))
              .thenAnswer((_) async => Right(tTvShowList));
          // Act
          await provider.fetchTvShowSearch(tQuery);
          // Assert
          expect(provider.state, RequestState.Loaded);
          expect(provider.searchResult, tTvShowList);
          expect(listenerCallCount, 2);
        });

    test('Should return error when data is unsuccessful', () async {
      // Arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // Act
      await provider.fetchTvShowSearch(tQuery);
      // Assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}