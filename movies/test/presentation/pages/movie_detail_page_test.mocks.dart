// Mocks generated by Mockito 5.0.15 from annotations
// in movies/test/presentation/pages/movie_detail_page_test.dart.
// Do not manually edit this file.

import 'package:bloc_test/bloc_test.dart' as _i8;
import 'package:core/core.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movies/presentation/bloc/movie_detail_bloc.dart' as _i4;
import 'package:movies/presentation/bloc/movie_detail_recommendation_bloc.dart'
    as _i7;
import 'package:movies/presentation/bloc/movie_detail_watchlist_bloc.dart'
    as _i6;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [MovieDetailBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieDetailBloc extends _i8.MockBloc<_i2.DetailEvent, _i2.DetailState> implements _i4.MovieDetailBloc {}

/// A class which mocks [MovieDetailWatchlistBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieDetailWatchlistBloc extends _i8.MockBloc<_i2.DetailWatchlistEvent, _i2.DetailWatchlistStatus>
    implements _i6.MovieDetailWatchlistBloc {}

/// A class which mocks [MovieDetailRecommendationBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieDetailRecommendationBloc extends _i8.MockBloc<_i2.DetailRecommendationEvent, _i2.DetailRecommendationState>
    implements _i7.MovieDetailRecommendationBloc {}

class MovieDetailEventFake extends _i1.Fake implements _i2.DetailEvent {}
class MovieDetailStateFake extends _i1.Fake implements _i2.DetailState {}
class MovieDetailWatchlistEventFake extends _i1.Fake implements _i2.DetailWatchlistEvent {}
class MovieDetailWatchlistStateFake extends _i1.Fake implements _i2.DetailWatchlistStatus {}
class MovieDetailRecommendationEventFake extends _i1.Fake implements _i2.DetailRecommendationEvent {}
class MovieDetailRecommendationStateFake extends _i1.Fake implements _i2.DetailRecommendationState {}
