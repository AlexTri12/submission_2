import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';

class MovieDetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(DetailEmpty());

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is FetchDetail) {
      final id = event.id;
      yield DetailLoading();

      final result = await _getMovieDetail.execute(id);
      yield* result.fold(
            (failure) async* {
          yield DetailError(failure.message);
        },
            (data) async* {
          yield DetailHasData<MovieDetail>(data);
        },
      );
    }
  }
}