import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';

class MovieDetailWatchlistBloc extends Bloc<DetailWatchlistEvent, DetailWatchlistStatus> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieDetailWatchlistBloc(
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(DetailWatchlistLoading());

  @override
  Stream<DetailWatchlistStatus> mapEventToState(DetailWatchlistEvent event) async* {
    String message = '';
    int id = -1;

    if (event is AddToWatchlist) {
      final movieDetail = cast<MovieDetail>(event.detail);
      final result = await _saveWatchlist.execute(movieDetail);

      await result.fold(
            (failure) async {
          message = failure.message;
        },
            (successMessage) async {
          message = successMessage;
        },
      );
      id = movieDetail.id;
    } else if (event is RemoveFromWatchlist) {
      final movieDetail = cast<MovieDetail>(event.detail);
      final result = await _removeWatchlist.execute(movieDetail);

      await result.fold(
            (failure) async {
          message = failure.message;
        },
            (successMessage) async {
          message = successMessage;
        },
      );
      id = movieDetail.id;
    }

    if (event is LoadWatchlistStatus) {
      id = event.id;
    }

    final result = await _getWatchListStatus.execute(id);
    message = result == true ? watchlistRemoveSuccessMessage : watchlistAddSuccessMessage;
    yield IsAddedToWatchlist(result, message);
  }
}
