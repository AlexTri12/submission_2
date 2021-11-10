import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/get_top_rated_tv_shows.dart';

class TvShowTopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRatedTvShows _getTopRatedTvShows;

  TvShowTopRatedBloc(this._getTopRatedTvShows) : super(TopRatedEmpty());

  @override
  Stream<TopRatedState> mapEventToState(TopRatedEvent event) async* {
    if (event is FetchTopRated) {
      yield TopRatedLoading();

      final result = await _getTopRatedTvShows.execute();
      yield* result.fold(
            (failure) async* {
          yield TopRatedError(failure.message);
        },
            (data) async* {
          yield TopRatedHasData<TvShow>(data);
        },
      );
    }
  }
}
