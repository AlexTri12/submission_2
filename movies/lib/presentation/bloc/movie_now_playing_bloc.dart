import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';

class MovieNowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(this._getNowPlayingMovies) : super(NowPlayingEmpty());

  @override
  Stream<NowPlayingState> mapEventToState(NowPlayingEvent event) async* {
    if (event is FetchNowPlaying) {
      yield NowPlayingLoading();

      final result = await _getNowPlayingMovies.execute();
      yield* result.fold(
            (failure) async* {
          yield NowPlayingError(failure.message);
        },
            (data) async* {
          yield NowPlayingHasData<Movie>(data);
        },
      );
    }
  }
}
