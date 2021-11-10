import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';

class MovieDetailRecommendationBloc extends Bloc<DetailRecommendationEvent, DetailRecommendationState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieDetailRecommendationBloc(this._getMovieRecommendations) : super(DetailRecommendationEmpty());

  @override
  Stream<DetailRecommendationState> mapEventToState(DetailRecommendationEvent event) async* {
    if (event is FetchDetailRecommendation) {
      final id = event.id;
      yield DetailRecommendationLoading();

      final result = await _getMovieRecommendations.execute(id);
      yield* result.fold(
            (failure) async* {
          yield DetailRecommendationError(failure.message);
        },
            (data) async* {
          yield DetailRecommendationHasData<Movie>(data);
        },
      );
    }
  }
}
