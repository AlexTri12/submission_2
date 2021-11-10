import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/get_popular_tv_shows.dart';
import 'package:tv_shows/presentation/bloc/tv_show_popular_bloc.dart';

import 'tv_show_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvShows])
void main() {
  late TvShowPopularBloc tvShowPopularBloc;
  late MockGetPopularTvShows mockGetPopularTvShows;

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
    mockGetPopularTvShows = MockGetPopularTvShows();
    tvShowPopularBloc = TvShowPopularBloc(mockGetPopularTvShows);
  });

  test('Initial state should be empty', () {
    expect(tvShowPopularBloc.state, PopularEmpty());
  });

  blocTest<TvShowPopularBloc, PopularState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      return tvShowPopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopular()),
    expect: () => [
      PopularLoading(),
      PopularHasData<TvShow>(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvShows.execute());
    },
  );

  blocTest<TvShowPopularBloc, PopularState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowPopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopular()),
    expect: () => [
      PopularLoading(),
      PopularError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvShows.execute());
    },
  );
}
