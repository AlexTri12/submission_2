import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/tv_shows.dart';
import 'package:tv_shows/presentation/pages/popular_tv_shows_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart' as mck;

import 'popular_tv_shows_page_test.mocks.dart';

@GenerateMocks([TvShowPopularBloc])
void main() {
  late MockTvShowPopularBloc mockBloc;

  setUpAll(() {
    mck.registerFallbackValue(TvShowPopularEventFake());
    mck.registerFallbackValue(TvShowPopularStateFake());
  });

  setUp(() {
    mockBloc = MockTvShowPopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<TvShowPopularBloc>(
        create: (c) => mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        mck.when(() => mockBloc.state)
            .thenAnswer((_) => PopularLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(PopularTvShowsPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        mck.when(() => mockBloc.state)
            .thenAnswer((_) => PopularHasData(<TvShow>[]));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(PopularTvShowsPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        mck.when(() => mockBloc.state)
            .thenAnswer((_) => PopularError('Error message'));

        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(PopularTvShowsPage()));

        expect(textFinder, findsOneWidget);
      });
}
