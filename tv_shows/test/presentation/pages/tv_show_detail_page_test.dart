import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/tv_shows.dart';
import 'package:tv_shows/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart' as mck;

import 'top_rated_tv_shows_page_test.mocks.dart';

@GenerateMocks([TvShowTopRatedBloc])
void main() {
  late MockTvShowTopRatedBloc mockBloc;

  setUpAll(() {
    mck.registerFallbackValue(TvShowTopRatedEventFake());
    mck.registerFallbackValue(TvShowTopRatedStateFake());
  });

  setUp(() {
    mockBloc = MockTvShowTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<TvShowTopRatedBloc>(
        create: (c) => mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        mck.when(() => mockBloc.state).thenAnswer((_) => TopRatedLoading());

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowsPage()));
        await tester.pump(Duration.zero);

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        mck.when(() => mockBloc.state).thenAnswer((_) => TopRatedHasData(<TvShow>[]));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowsPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        mck.when(() => mockBloc.state).thenAnswer((_) => TopRatedError('Error message'));

        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowsPage()));

        expect(textFinder, findsOneWidget);
      });
}
