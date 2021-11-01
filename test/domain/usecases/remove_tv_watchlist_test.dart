import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvWatchlist useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = RemoveTvWatchlist(mockTvShowRepository);
  });

  test('Should remove watchlist TV Show from repository', () async {
    // Arrange
    when(mockTvShowRepository.removeTvWatchlist(testTvShowDetail))
        .thenAnswer((_) async => Right("Removed from watchlist"));
    // Act
    final result = await useCase.execute(testTvShowDetail);
    // Assert
    verify(mockTvShowRepository.removeTvWatchlist(testTvShowDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
