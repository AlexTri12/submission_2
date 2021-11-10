import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart' as mck;

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailBloc, MovieDetailWatchlistBloc, MovieDetailRecommendationBloc])
void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieDetailWatchlistBloc mockMovieDetailWatchlistBloc;
  late MockMovieDetailRecommendationBloc mockMovieDetailRecommendationBloc;

  setUpAll(() {
    mck.registerFallbackValue(MovieDetailEventFake());
    mck.registerFallbackValue(MovieDetailStateFake());
    mck.registerFallbackValue(MovieDetailWatchlistEventFake());
    mck.registerFallbackValue(MovieDetailWatchlistStateFake());
    mck.registerFallbackValue(MovieDetailRecommendationEventFake());
    mck.registerFallbackValue(MovieDetailRecommendationStateFake());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieDetailWatchlistBloc = MockMovieDetailWatchlistBloc();
    mockMovieDetailRecommendationBloc = MockMovieDetailRecommendationBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (_) => mockMovieDetailBloc,
        ),
        BlocProvider<MovieDetailWatchlistBloc>(
          create: (_) => mockMovieDetailWatchlistBloc,
        ),
        BlocProvider<MovieDetailRecommendationBloc>(
          create: (_) => mockMovieDetailRecommendationBloc,
        ),
      ],
      child: MaterialApp(
          home: body
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    mck.when(() => mockMovieDetailBloc.state)
        .thenAnswer((_) => DetailHasData<MovieDetail>(testMovieDetail));
    mck.when(() => mockMovieDetailRecommendationBloc.state)
        .thenAnswer((_) => DetailRecommendationHasData(<Movie>[]));
    mck.when(() => mockMovieDetailWatchlistBloc.state)
        .thenAnswer((_) => IsAddedToWatchlist(false, MovieDetailWatchlistBloc.watchlistAddSuccessMessage));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    mck.when(() => mockMovieDetailBloc.state)
        .thenAnswer((_) => DetailHasData<MovieDetail>(testMovieDetail));
    mck.when(() => mockMovieDetailRecommendationBloc.state)
        .thenAnswer((_) => DetailRecommendationHasData(<Movie>[]));
    mck.when(() => mockMovieDetailWatchlistBloc.state)
        .thenAnswer((_) => IsAddedToWatchlist(true, MovieDetailWatchlistBloc.watchlistRemoveSuccessMessage));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    mck.when(() => mockMovieDetailBloc.state)
        .thenAnswer((_) => DetailHasData<MovieDetail>(testMovieDetail));
    mck.when(() => mockMovieDetailRecommendationBloc.state)
        .thenAnswer((_) => DetailRecommendationHasData(<Movie>[]));
    mck.when(() => mockMovieDetailWatchlistBloc.state)
        .thenAnswer((_) => IsAddedToWatchlist(false, MovieDetailWatchlistBloc.watchlistAddSuccessMessage));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    mck.when(() => mockMovieDetailBloc.state)
        .thenAnswer((_) => DetailHasData<MovieDetail>(testMovieDetail));
    mck.when(() => mockMovieDetailRecommendationBloc.state)
        .thenAnswer((_) => DetailRecommendationHasData(<Movie>[]));
    mck.when(() => mockMovieDetailWatchlistBloc.state)
        .thenAnswer((_) => IsAddedToWatchlist(false, 'Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
