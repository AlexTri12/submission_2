import 'package:core/core.dart';
import 'package:tv_shows/data/datasources/tv_show_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowLocalDataSourceImpl dataSource;
  late MockDatabaseHelperTv mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelperTv();
    dataSource = TvShowLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('Save Watchlist', () {
    test('Should return success message when insert to database is success', () async {
      // Arrange
      when(mockDatabaseHelper.insertTvWatchlist(testTvShowTable))
          .thenAnswer((_) async => 1);
      // Act
      final result = await dataSource.insertWatchlistTv(testTvShowTable);
      // Assert
      expect(result, 'Added to Watchlist');
    });

    test('Should throw DatabaseException when insert to database is failed', () async {
      // Arrange
      when(mockDatabaseHelper.insertTvWatchlist(testTvShowTable))
          .thenThrow(Exception());
      // Act
      final call = dataSource.insertWatchlistTv(testTvShowTable);
      // Assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove Watchlist', () {
    test('Should return success message when remove to database is success', () async {
      // Arrange
      when(mockDatabaseHelper.removeTvWatchlist(testTvShowTable))
          .thenAnswer((_) async => 1);
      // Act
      final result = await dataSource.removeWatchlistTv(testTvShowTable);
      // Assert
      expect(result, 'Removed from Watchlist');
    });

    test('Should throw DatabaseException when remove to database is failed', () async {
      // Arrange
      when(mockDatabaseHelper.removeTvWatchlist(testTvShowTable))
          .thenThrow(Exception());
      // Act
      final call = dataSource.removeWatchlistTv(testTvShowTable);
      // Assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TV Show detail by id', () {
    final tId = 1;
    test('Should return TV Show detail table when data is found', () async {
      // Arrange
      when(mockDatabaseHelper.getTvShowById(tId))
          .thenAnswer((_) async => testTvShowMap);
      // Act
      final result = await dataSource.getTvShowById(tId);
      // Assert
      expect(result, testTvShowTable);
    });

    test('Should return null when data is not found', () async {
      // Arrange
      when(mockDatabaseHelper.getTvShowById(tId))
          .thenAnswer((_) async => null);
      // Act
      final result = await dataSource.getTvShowById(tId);
      // Assert
      expect(result, null);
    });
  });

  group('Get watchlist TV shows', () {
    test('Should return list of TvShowTable from database', () async {
      // Arrange
      when(mockDatabaseHelper.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvShowMap]);
      // Act
      final result = await dataSource.getWatchlistTvShows();
      // Assert
      expect(result, [testTvShowTable]);
    });
  });
}