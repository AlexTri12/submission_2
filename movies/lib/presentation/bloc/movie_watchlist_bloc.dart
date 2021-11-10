import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';

class MovieWatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistMovies _getWatchlistMovies;

  MovieWatchlistBloc(this._getWatchlistMovies) : super(WatchlistEmpty());

  @override
  Stream<WatchlistState> mapEventToState(WatchlistEvent event) async* {
    if (event is FetchWatchlist) {
      yield WatchlistLoading();

      final result = await _getWatchlistMovies.execute();
      yield* result.fold(
            (failure) async* {
          yield WatchlistError(failure.message);
        },
            (data) async* {
          yield WatchlistHasData<Movie>(data);
        },
      );
    }
  }
}
