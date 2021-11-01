import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_shows_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_tv_shows_page_test.mocks.dart';

@GenerateMocks([
  TopRatedTvShowsNotifier,
])
void main() {
  late MockTopRatedTvShowsNotifier mockTopRatedTvShowsNotifier;

  setUp(() {
    mockTopRatedTvShowsNotifier = MockTopRatedTvShowsNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvShowsNotifier>.value(
      value: mockTopRatedTvShowsNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading', (WidgetTester tester) async {
    // Arrange
    when(mockTopRatedTvShowsNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    // Act
    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowsPage()));
    // Assert
    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded', (WidgetTester tester) async {
    // Arrange
    when(mockTopRatedTvShowsNotifier.state).thenReturn(RequestState.Loaded);
    when(mockTopRatedTvShowsNotifier.tvShows).thenReturn(<TvShow>[]);

    final listViewFinder = find.byType(ListView);
    // Act
    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowsPage()));
    // Assert
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when error', (WidgetTester tester) async {
    // Arrange
    when(mockTopRatedTvShowsNotifier.state).thenReturn(RequestState.Error);
    when(mockTopRatedTvShowsNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));
    // Act
    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowsPage()));
    // Assert
    expect(textFinder, findsOneWidget);
  });
}