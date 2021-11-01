import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvShows useCase;
  late MockTvShowRepository mockTvShowRpository;

  setUp(() {
    mockTvShowRpository = MockTvShowRepository();
    useCase = GetPopularTvShows(mockTvShowRpository);
  });

  final tTvShows = <TvShow>[];

  test('Should get list of TV Shows from the repository when execute function is called', () async {
    // Arrange
    when(mockTvShowRpository.getPopularTvShows())
        .thenAnswer((_) async => Right(tTvShows));
    // Act
    final result = await useCase.execute();
    // Assert
    expect(result, Right(tTvShows));
  });
}
