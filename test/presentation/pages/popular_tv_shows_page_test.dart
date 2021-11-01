import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/pages/popular_tv_shows_page.dart';
import 'package:ditonton/presentation/provider/popular_tv_shows_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'popular_tv_shows_page_test.mocks.dart';

@GenerateMocks([
  PopularTvShowsNotifier,
])
void main() {
  late MockPopularTvShowsNotifier mockPopularTvShowsNotifier;

  setUp(() {
    mockPopularTvShowsNotifier = MockPopularTvShowsNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularTvShowsNotifier>.value(
      value: mockPopularTvShowsNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading', (WidgetTester tester) async {
    // Arrange
    when(mockPopularTvShowsNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    // Act
    await tester.pumpWidget(_makeTestableWidget(PopularTvShowsPage()));
    // Assert
    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded', (WidgetTester tester) async {
    // Arrange
    when(mockPopularTvShowsNotifier.state).thenReturn(RequestState.Loaded);
    when(mockPopularTvShowsNotifier.tvShows).thenReturn(<TvShow>[]);

    final listViewFinder = find.byType(ListView);
    // Act
    await tester.pumpWidget(_makeTestableWidget(PopularTvShowsPage()));
    // Assert
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when error', (WidgetTester tester) async {
    // Arrange
    when(mockPopularTvShowsNotifier.state).thenReturn(RequestState.Error);
    when(mockPopularTvShowsNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));
    // Act
    await tester.pumpWidget(_makeTestableWidget(PopularTvShowsPage()));
    // Assert
    expect(textFinder, findsOneWidget);
  });
}