import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/domain/entities/tv_show_detail.dart';
import 'package:tv_shows/domain/usecases/get_tv_show_detail.dart';
import 'package:tv_shows/presentation/bloc/tv_show_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvShowDetail])
void main() {
  late TvShowDetailBloc tvShowDetailBloc;
  late MockGetTvShowDetail mockGetTvShowDetail;

  final tId = 1;

  setUp(() {
    mockGetTvShowDetail = MockGetTvShowDetail();
    tvShowDetailBloc = TvShowDetailBloc(mockGetTvShowDetail);
  });

  test('Initial state should be empty', () {
    expect(tvShowDetailBloc.state, DetailEmpty());
  });

  blocTest<TvShowDetailBloc, DetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(FetchDetail(tId)),
    expect: () => [
      DetailLoading(),
      DetailHasData<TvShowDetail>(testTvShowDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvShowDetail.execute(tId));
    },
  );

  blocTest<TvShowDetailBloc, DetailState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(FetchDetail(tId)),
    expect: () => [
      DetailLoading(),
      DetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvShowDetail.execute(tId));
    },
  );
}
