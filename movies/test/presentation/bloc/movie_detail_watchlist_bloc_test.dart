import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late MovieDetailWatchlistBloc movieDetailWatchlistBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  final tId = 1;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailWatchlistBloc = MovieDetailWatchlistBloc(
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  test('Initial state should be loading', () {
    expect(movieDetailWatchlistBloc.state, DetailWatchlistLoading());
  });

  blocTest<MovieDetailWatchlistBloc, DetailWatchlistStatus>(
    'Should emit boolean and message when successful getting watchlist status',
    build: () {
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => false);
      return movieDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
    expect: () => [
      IsAddedToWatchlist(false, MovieDetailWatchlistBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<MovieDetailWatchlistBloc, DetailWatchlistStatus>(
    'Should emit boolean and message when successful getting watchlist status',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => true);
      return movieDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddToWatchlist(testMovieDetail)),
    expect: () => [
      IsAddedToWatchlist(true, MovieDetailWatchlistBloc.watchlistRemoveSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<MovieDetailWatchlistBloc, DetailWatchlistStatus>(
    'Should emit boolean and message when successful getting watchlist status',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => false);
      return movieDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
    expect: () => [
      IsAddedToWatchlist(false, MovieDetailWatchlistBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
      verify(mockGetWatchListStatus.execute(tId));
    },
  );
}
