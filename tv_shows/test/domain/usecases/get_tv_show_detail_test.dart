import 'package:dartz/dartz.dart';
import 'package:tv_shows/domain/usecases/get_tv_show_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowDetail useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetTvShowDetail(mockTvShowRepository);
  });

  final tId = 1;

  test('Should get TV show detail from the repository', () async {
    // Arrange
    when(mockTvShowRepository.getTvShowDetail(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    // Act
    final result = await useCase.execute(tId);
    // Assert
    expect(result, Right(testTvShowDetail));
  });
}