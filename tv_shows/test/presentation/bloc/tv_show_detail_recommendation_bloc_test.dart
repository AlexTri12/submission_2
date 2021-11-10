import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/event/detail_recommendation_event.dart';
import 'package:core/bloc/state/detail_recommendation_state.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/get_tv_show_recommendations.dart';
import 'package:tv_shows/presentation/bloc/tv_show_detail_recommendation_bloc.dart';

import 'tv_show_detail_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvShowRecommendations])
void main() {
  late TvShowDetailRecommendationBloc tvShowDetailRecommendationBloc;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;

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
  final tId = 1;

  setUp(() {
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    tvShowDetailRecommendationBloc = TvShowDetailRecommendationBloc(mockGetTvShowRecommendations);
  });

  test('Initial state should be empty', () {
    expect(tvShowDetailRecommendationBloc.state, DetailRecommendationEmpty());
  });

  blocTest<TvShowDetailRecommendationBloc, DetailRecommendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvShowList));
      return tvShowDetailRecommendationBloc;
    },
    act: (bloc) => bloc.add(FetchDetailRecommendation(tId)),
    expect: () => [
      DetailRecommendationLoading(),
      DetailRecommendationHasData<TvShow>(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetTvShowRecommendations.execute(tId));
    },
  );

  blocTest<TvShowDetailRecommendationBloc, DetailRecommendationState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowDetailRecommendationBloc;
    },
    act: (bloc) => bloc.add(FetchDetailRecommendation(tId)),
    expect: () => [
      DetailRecommendationLoading(),
      DetailRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvShowRecommendations.execute(tId));
    },
  );
}
