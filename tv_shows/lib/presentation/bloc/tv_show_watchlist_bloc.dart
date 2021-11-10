import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/get_watchlist_tv_shows.dart';

class TvShowWatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistTvShows _getWatchlistTvShows;

  TvShowWatchlistBloc(this._getWatchlistTvShows) : super(WatchlistEmpty());

  @override
  Stream<WatchlistState> mapEventToState(WatchlistEvent event) async* {
    if (event is FetchWatchlist) {
      yield WatchlistLoading();

      final result = await _getWatchlistTvShows.execute();
      yield* result.fold(
            (failure) async* {
          yield WatchlistError(failure.message);
        },
            (data) async* {
          yield WatchlistHasData<TvShow>(data);
        },
      );
    }
  }
}
