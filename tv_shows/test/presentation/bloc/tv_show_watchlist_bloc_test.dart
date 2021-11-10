import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/get_watchlist_tv_shows.dart';
import 'package:tv_shows/presentation/bloc/tv_show_watchlist_bloc.dart';

import 'tv_show_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvShows])
void main() {
  late TvShowWatchlistBloc tvShowWatchlistBloc;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;

  final tTvShowModel = TvShow(
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
  final tTvShowList = <TvShow>[tTvShowModel];

  setUp(() {
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();
    tvShowWatchlistBloc = TvShowWatchlistBloc(mockGetWatchlistTvShows);
  });

  test('Initial state should be empty', () {
    expect(tvShowWatchlistBloc.state, WatchlistEmpty());
  });

  blocTest<TvShowWatchlistBloc, WatchlistState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      return tvShowWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlist()),
    expect: () => [
      WatchlistLoading(),
      WatchlistHasData<TvShow>(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvShows.execute());
    },
  );

  blocTest<TvShowWatchlistBloc, WatchlistState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlist()),
    expect: () => [
      WatchlistLoading(),
      WatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvShows.execute());
    },
  );
}
