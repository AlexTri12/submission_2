import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/get_now_playing_tv_shows.dart';

class TvShowNowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final GetNowPlayingTvShows _getNowPlayingTvShows;

  TvShowNowPlayingBloc(this._getNowPlayingTvShows) : super(NowPlayingEmpty());

  @override
  Stream<NowPlayingState> mapEventToState(NowPlayingEvent event) async* {
    if (event is FetchNowPlaying) {
      yield NowPlayingLoading();

      final result = await _getNowPlayingTvShows.execute();
      yield* result.fold(
            (failure) async* {
          yield NowPlayingError(failure.message);
        },
            (data) async* {
          yield NowPlayingHasData<TvShow>(data);
        },
      );
    }
  }
}
