import 'package:core/core.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/presentation/pages/tv_show_detail_page.dart';
import 'package:tv_shows/presentation/provider/tv_show_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_page_test.mocks.dart';

@GenerateMocks([
  TvShowDetailNotifier,
])
void main() {
  late MockTvShowDetailNotifier mockTvShowDetailNotifier;

  setUp(() {
    mockTvShowDetailNotifier = MockTvShowDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvShowDetailNotifier>.value(
      value: mockTvShowDetailNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Watchlist button should display add icon when TV show not added to watchlist', (WidgetTester tester) async {
    // Arrange
    when(mockTvShowDetailNotifier.tvShowState).thenReturn(RequestState.Loaded);
    when(mockTvShowDetailNotifier.tvShow).thenReturn(testTvShowDetail);
    when(mockTvShowDetailNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockTvShowDetailNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
    when(mockTvShowDetailNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);
    // Act
    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1416)));
    // Assert
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Watchlist button should display check icon when TV show is added to watchlist', (WidgetTester tester) async {
    // Arrange
    when(mockTvShowDetailNotifier.tvShowState).thenReturn(RequestState.Loaded);
    when(mockTvShowDetailNotifier.tvShow).thenReturn(testTvShowDetail);
    when(mockTvShowDetailNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockTvShowDetailNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
    when(mockTvShowDetailNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);
    // Act
    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1416)));
    // Assert
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Watchlist button should display snack bar when added to watchlist', (WidgetTester tester) async {
    // Arrange
    when(mockTvShowDetailNotifier.tvShowState).thenReturn(RequestState.Loaded);
    when(mockTvShowDetailNotifier.tvShow).thenReturn(testTvShowDetail);
    when(mockTvShowDetailNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockTvShowDetailNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
    when(mockTvShowDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockTvShowDetailNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);
    // Act create the UI
    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1416)));
    // Assert before add to watchlist
    expect(find.byIcon(Icons.add), findsOneWidget);
    // Act tap button
    await tester.tap(watchlistButton);
    await tester.pump();
    // Assert snack bar and text added to watchlist
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets('Watchlist button should display AlertDialog when add to watchlist failed', (WidgetTester tester) async {
    // Arrange
    when(mockTvShowDetailNotifier.tvShowState).thenReturn(RequestState.Loaded);
    when(mockTvShowDetailNotifier.tvShow).thenReturn(testTvShowDetail);
    when(mockTvShowDetailNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockTvShowDetailNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
    when(mockTvShowDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockTvShowDetailNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);
    // Act create the UI
    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1416)));
    // Assert before add to watchlist
    expect(find.byIcon(Icons.add), findsOneWidget);
    // Act tap button
    await tester.tap(watchlistButton);
    await tester.pump();
    // Assert AlertDialog and text failed
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}