import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';

class MoviePopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(this._getPopularMovies) : super(PopularEmpty());

  @override
  Stream<PopularState> mapEventToState(PopularEvent event) async* {
    if (event is FetchPopular) {
      yield PopularLoading();

      final result = await _getPopularMovies.execute();
      yield* result.fold(
            (failure) async* {
          yield PopularError(failure.message);
        },
            (data) async* {
          yield PopularHasData<Movie>(data);
        },
      );
    }
  }
}
