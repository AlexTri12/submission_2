import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/search_tv_shows.dart';
import 'package:tv_shows/presentation/bloc/tv_show_search_bloc.dart';

import 'tv_show_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvShows])
void main() {
  late TvShowSearchBloc tvShowSearchBloc;
  late MockSearchTvShows mockSearchTvShows;

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

  setUp(() {
    mockSearchTvShows = MockSearchTvShows();
    tvShowSearchBloc = TvShowSearchBloc(mockSearchTvShows);
  });

  test('Initial state should be empty', () {
    expect(tvShowSearchBloc.state, SearchEmpty());
  });

  blocTest<TvShowSearchBloc, SearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      return tvShowSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData<TvShow>(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockSearchTvShows.execute(tQuery));
    },
  );

  blocTest<TvShowSearchBloc, SearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvShows.execute(tQuery));
    },
  );
}