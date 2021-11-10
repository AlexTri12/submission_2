import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart' as mck;

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([MovieTopRatedBloc])
void main() {
  late MockMovieTopRatedBloc mockBloc;

  setUpAll(() {
    mck.registerFallbackValue(MovieTopRatedEventFake());
    mck.registerFallbackValue(MovieTopRatedStateFake());
  });

  setUp(() {
    mockBloc = MockMovieTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedBloc>(
      create: (c) => mockBloc,
      child: body,
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(TopRatedLoading());
    when(mockBloc.state).thenAnswer((_) => TopRatedLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
    await tester.pump(Duration.zero);

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  // testWidgets('Page should display when data is loaded',
  //     (WidgetTester tester) async {
  //   when(mockBloc.state).thenReturn(RequestState.Loaded);
  //   when(mockBloc).thenReturn(<Movie>[]);
  //
  //   final listViewFinder = find.byType(ListView);
  //
  //   await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
  //
  //   expect(listViewFinder, findsOneWidget);
  // });
  //
  // testWidgets('Page should display text with message when Error',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.Error);
  //   when(mockNotifier.message).thenReturn('Error message');
  //
  //   final textFinder = find.byKey(Key('error_message'));
  //
  //   await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
  //
  //   expect(textFinder, findsOneWidget);
  // });
}
