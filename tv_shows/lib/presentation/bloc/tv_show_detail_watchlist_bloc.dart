import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/domain/entities/tv_show_detail.dart';
import 'package:tv_shows/domain/usecases/get_watchlist_tv_show_status.dart';
import 'package:tv_shows/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv_shows/domain/usecases/save_tv_watchlist.dart';

class TvShowDetailWatchlistBloc extends Bloc<DetailWatchlistEvent, DetailWatchlistStatus> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistTvShowStatus _getWatchListStatus;
  final SaveTvWatchlist _saveWatchlist;
  final RemoveTvWatchlist _removeWatchlist;

  TvShowDetailWatchlistBloc(
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(DetailWatchlistLoading());

  @override
  Stream<DetailWatchlistStatus> mapEventToState(DetailWatchlistEvent event) async* {
    String message = '';
    int id = -1;

    if (event is AddToWatchlist) {
      final tvShowDetail = cast<TvShowDetail>(event.detail);
      final result = await _saveWatchlist.execute(tvShowDetail);

      await result.fold(
            (failure) async {
          message = failure.message;
        },
            (successMessage) async {
          message = successMessage;
        },
      );
      id = tvShowDetail.id;
    } else if (event is RemoveFromWatchlist) {
      final tvShowDetail = cast<TvShowDetail>(event.detail);
      final result = await _removeWatchlist.execute(tvShowDetail);

      await result.fold(
            (failure) async {
          message = failure.message;
        },
            (successMessage) async {
          message = successMessage;
        },
      );
      id = tvShowDetail.id;
    }

    if (event is LoadWatchlistStatus) {
      id = event.id;
    }

    final result = await _getWatchListStatus.execute(id);
    message = result == true ? watchlistRemoveSuccessMessage : watchlistAddSuccessMessage;
    yield IsAddedToWatchlist(result, message);
  }
}
