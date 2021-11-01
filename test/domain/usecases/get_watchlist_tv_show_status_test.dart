import 'package:ditonton/domain/usecases/get_watchlist_tv_show_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvShowStatus useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetWatchlistTvShowStatus(mockTvShowRepository);
  });

  test('Should get watchlist status from repository', () async {
    // Arrange
    when(mockTvShowRepository.isAddedToTvWatchlist(1))
        .thenAnswer((_) async => true);
    // Act
    final result = await useCase.execute(1);
    // Assert
    expect(result, true);
  });
}
