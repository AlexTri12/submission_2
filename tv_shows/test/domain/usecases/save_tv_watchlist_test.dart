import 'package:dartz/dartz.dart';
import 'package:tv_shows/domain/usecases/save_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTvWatchlist useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = SaveTvWatchlist(mockTvShowRepository);
  });

  test('Should save TV Show to the repository', () async {
    // Arrange
    when(mockTvShowRepository.saveTvWatchlist(testTvShowDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // Act
    final result = await useCase.execute(testTvShowDetail);
    // Assert
    verify(mockTvShowRepository.saveTvWatchlist(testTvShowDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
