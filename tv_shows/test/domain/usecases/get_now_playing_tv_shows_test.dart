import 'package:dartz/dartz.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/get_now_playing_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvShows useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetNowPlayingTvShows(mockTvShowRepository);
  });

  final tTvShows = <TvShow>[];

  test('Should get list of TV Shows from the repository', () async {
    // Arrange
    when(mockTvShowRepository.getNowPlayingTvShows())
        .thenAnswer((_) async => Right(tTvShows));
    // Act
    final result = await useCase.execute();
    // Assert
    expect(result, Right(tTvShows));
  });
}