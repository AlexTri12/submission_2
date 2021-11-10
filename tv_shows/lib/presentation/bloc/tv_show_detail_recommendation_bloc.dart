import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/get_tv_show_recommendations.dart';

class TvShowDetailRecommendationBloc extends Bloc<DetailRecommendationEvent, DetailRecommendationState> {
  final GetTvShowRecommendations _getTvShowRecommendations;

  TvShowDetailRecommendationBloc(this._getTvShowRecommendations) : super(DetailRecommendationEmpty());

  @override
  Stream<DetailRecommendationState> mapEventToState(DetailRecommendationEvent event) async* {
    if (event is FetchDetailRecommendation) {
      final id = event.id;
      yield DetailRecommendationLoading();

      final result = await _getTvShowRecommendations.execute(id);
      yield* result.fold(
            (failure) async* {
          yield DetailRecommendationError(failure.message);
        },
            (data) async* {
          yield DetailRecommendationHasData<TvShow>(data);
        },
      );
    }
  }
}
