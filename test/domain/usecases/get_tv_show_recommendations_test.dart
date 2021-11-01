import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_tv_show_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowRecommendations useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetTvShowRecommendations(mockTvShowRepository);
  });

  final tId = 1;
  final tTvShows = <TvShow>[];

  test('Should get list of TV Show recommendations from the repository',
          () async {
        // Arrange
        when(mockTvShowRepository.getTvShowRecommendations(tId))
            .thenAnswer((_) async => Right(tTvShows));
        // Act
        final result = await useCase.execute(tId);
        // Assert
        expect(result, Right(tTvShows));
      });
}