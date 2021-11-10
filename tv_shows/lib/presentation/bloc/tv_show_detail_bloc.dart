import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/domain/entities/tv_show_detail.dart';
import 'package:tv_shows/domain/usecases/get_tv_show_detail.dart';

class TvShowDetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetTvShowDetail _getTvShowDetail;

  TvShowDetailBloc(this._getTvShowDetail) : super(DetailEmpty());

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is FetchDetail) {
      final id = event.id;
      yield DetailLoading();

      final result = await _getTvShowDetail.execute(id);
      yield* result.fold(
            (failure) async* {
          yield DetailError(failure.message);
        },
            (data) async* {
          yield DetailHasData<TvShowDetail>(data);
        },
      );
    }
  }
}