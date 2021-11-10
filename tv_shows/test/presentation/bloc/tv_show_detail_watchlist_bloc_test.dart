import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/domain/entities/tv_show_detail.dart';
import 'package:tv_shows/domain/usecases/get_watchlist_tv_show_status.dart';
import 'package:tv_shows/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv_shows/domain/usecases/save_tv_watchlist.dart';
import 'package:tv_shows/presentation/bloc/tv_show_detail_watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvShowStatus, SaveTvWatchlist, RemoveTvWatchlist])
void main() {
  late TvShowDetailWatchlistBloc tvShowDetailWatchlistBloc;
  late MockGetWatchlistTvShowStatus mockGetWatchListStatus;
  late MockSaveTvWatchlist mockSaveWatchlist;
  late MockRemoveTvWatchlist mockRemoveWatchlist;

  final tId = 1416;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchlistTvShowStatus();
    mockSaveWatchlist = MockSaveTvWatchlist();
    mockRemoveWatchlist = MockRemoveTvWatchlist();
    tvShowDetailWatchlistBloc = TvShowDetailWatchlistBloc(
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  test('Initial state should be loading', () {
    expect(tvShowDetailWatchlistBloc.state, DetailWatchlistLoading());
  });

  blocTest<TvShowDetailWatchlistBloc, DetailWatchlistStatus>(
    'Should emit boolean and message when successful getting watchlist status',
    build: () {
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => false);
      return tvShowDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
    expect: () => [
      IsAddedToWatchlist(false, TvShowDetailWatchlistBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<TvShowDetailWatchlistBloc, DetailWatchlistStatus>(
    'Should emit boolean and message when successful getting watchlist status',
    build: () {
      when(mockSaveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => true);
      return tvShowDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddToWatchlist<TvShowDetail>(testTvShowDetail)),
    expect: () => [
      IsAddedToWatchlist(true, TvShowDetailWatchlistBloc.watchlistRemoveSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvShowDetail));
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<TvShowDetailWatchlistBloc, DetailWatchlistStatus>(
    'Should emit boolean and message when successful getting watchlist status',
    build: () {
      when(mockRemoveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => false);
      return tvShowDetailWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist<TvShowDetail>(testTvShowDetail)),
    expect: () => [
      IsAddedToWatchlist(false, TvShowDetailWatchlistBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvShowDetail));
      verify(mockGetWatchListStatus.execute(tId));
    },
  );
}
