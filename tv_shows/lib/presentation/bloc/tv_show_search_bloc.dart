import 'package:core/core.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/search_tv_shows.dart';

class TvShowSearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTvShows _searchTvShows;

  TvShowSearchBloc(this._searchTvShows) : super(SearchEmpty());

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events,
      TransitionFunction<SearchEvent, SearchState> transitionFn,
      ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is OnQueryChanged) {
      final query = event.query;
      yield SearchLoading();

      final result= await _searchTvShows.execute(query);
      yield* result.fold(
            (failure) async* {
          yield SearchError(failure.message);
        },
            (data) async* {
          yield SearchHasData<TvShow>(data);
        },
      );
    }
  }
}