import 'dart:async';

import 'package:tv_shows/data/models/tv_show_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperTv {
  static DatabaseHelperTv? _databaseHelper;
  DatabaseHelperTv._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelperTv() => _databaseHelper ?? DatabaseHelperTv._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWatchlistTv = 'watchlist_tv';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton_tv.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tblWatchlistTv (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertTvWatchlist(TvShowTable tvShow) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTv, tvShow.toJson());
  }

  Future<int> removeTvWatchlist(TvShowTable tvShow) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [tvShow.id],
    );
  }

  Future<Map<String, dynamic>?> getTvShowById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [id]
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvShows() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlistTv);
    return results;
  }
}
