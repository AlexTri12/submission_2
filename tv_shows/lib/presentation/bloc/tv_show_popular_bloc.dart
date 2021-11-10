import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/get_popular_tv_shows.dart';

class TvShowPopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularTvShows _getPopularTvShows;

  TvShowPopularBloc(this._getPopularTvShows) : super(PopularEmpty());

  @override
  Stream<PopularState> mapEventToState(PopularEvent event) async* {
    if (event is FetchPopular) {
      yield PopularLoading();

      final result = await _getPopularTvShows.execute();
      yield* result.fold(
            (failure) async* {
          yield PopularError(failure.message);
        },
            (data) async* {
          yield PopularHasData<TvShow>(data);
        },
      );
    }
  }
}
