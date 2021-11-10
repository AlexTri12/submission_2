import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/event/detail_recommendation_event.dart';
import 'package:core/bloc/state/detail_recommendation_state.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/movies.dart';

import 'movie_detail_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieDetailRecommendationBloc movieDetailRecommendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tId = 1;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieDetailRecommendationBloc = MovieDetailRecommendationBloc(mockGetMovieRecommendations);
  });

  test('Initial state should be empty', () {
    expect(movieDetailRecommendationBloc.state, DetailRecommendationEmpty());
  });

  blocTest<MovieDetailRecommendationBloc, DetailRecommendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovieList));
      return movieDetailRecommendationBloc;
    },
    act: (bloc) => bloc.add(FetchDetailRecommendation(tId)),
    expect: () => [
      DetailRecommendationLoading(),
      DetailRecommendationHasData<Movie>(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );

  blocTest<MovieDetailRecommendationBloc, DetailRecommendationState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieDetailRecommendationBloc;
    },
    act: (bloc) => bloc.add(FetchDetailRecommendation(tId)),
    expect: () => [
      DetailRecommendationLoading(),
      DetailRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );
}
