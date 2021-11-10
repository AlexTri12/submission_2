import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

class MovieTopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(this._getTopRatedMovies) : super(TopRatedEmpty());

  @override
  Stream<TopRatedState> mapEventToState(TopRatedEvent event) async* {
    if (event is FetchTopRated) {
      yield TopRatedLoading();

      final result = await _getTopRatedMovies.execute();
      yield* result.fold(
            (failure) async* {
          yield TopRatedError(failure.message);
        },
            (data) async* {
          yield TopRatedHasData<Movie>(data);
        },
      );
    }
  }
}
