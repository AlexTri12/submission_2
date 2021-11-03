// Mocks generated by Mockito 5.0.15 from annotations
// in tv_shows/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;
import 'dart:convert' as _i18;
import 'dart:typed_data' as _i19;

import 'package:core/core.dart' as _i11;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/io_client.dart' as _i4;
import 'package:http/src/base_request.dart' as _i17;
import 'package:http/src/response.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i8;
import 'package:tv_shows/data/datasources/db/database_helper_tv.dart' as _i6;
import 'package:tv_shows/data/datasources/tv_show_local_data_source.dart'
    as _i16;
import 'package:tv_shows/data/datasources/tv_show_remote_data_source.dart'
    as _i14;
import 'package:tv_shows/data/models/tv_show_detail_model.dart' as _i3;
import 'package:tv_shows/data/models/tv_show_model.dart' as _i15;
import 'package:tv_shows/data/models/tv_show_table.dart' as _i9;
import 'package:tv_shows/domain/entities/tv_show.dart' as _i12;
import 'package:tv_shows/domain/entities/tv_show_detail.dart' as _i13;
import 'package:tv_shows/domain/repositories/tv_show_repository.dart' as _i10;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeTvShowDetailModel_1 extends _i1.Fake
    implements _i3.TvShowDetailModel {}

class _FakeIOStreamedResponse_2 extends _i1.Fake
    implements _i4.IOStreamedResponse {}

class _FakeResponse_3 extends _i1.Fake implements _i5.Response {}

/// A class which mocks [DatabaseHelperTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelperTv extends _i1.Mock implements _i6.DatabaseHelperTv {
  MockDatabaseHelperTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i8.Database?> get database => (super.noSuchMethod(
      Invocation.getter(#database),
      returnValue: Future<_i8.Database?>.value()) as _i7.Future<_i8.Database?>);
  @override
  _i7.Future<int> insertTvWatchlist(_i9.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertTvWatchlist, [tvShow]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeTvWatchlist(_i9.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeTvWatchlist, [tvShow]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getTvShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [TvShowRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRepository extends _i1.Mock implements _i10.TvShowRepository {
  MockTvShowRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>
      getNowPlayingTvShows() =>
          (super.noSuchMethod(Invocation.method(#getNowPlayingTvShows, []),
                  returnValue:
                      Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>.value(
                          _FakeEither_0<_i11.Failure, List<_i12.TvShow>>()))
              as _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
              returnValue:
                  Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>.value(
                      _FakeEither_0<_i11.Failure, List<_i12.TvShow>>()))
          as _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>
      getTopRatedTvShows() =>
          (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
                  returnValue:
                      Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>.value(
                          _FakeEither_0<_i11.Failure, List<_i12.TvShow>>()))
              as _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, _i13.TvShowDetail>> getTvShowDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
              returnValue:
                  Future<_i2.Either<_i11.Failure, _i13.TvShowDetail>>.value(
                      _FakeEither_0<_i11.Failure, _i13.TvShowDetail>()))
          as _i7.Future<_i2.Either<_i11.Failure, _i13.TvShowDetail>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>
      getTvShowRecommendations(int? id) => (super.noSuchMethod(
              Invocation.method(#getTvShowRecommendations, [id]),
              returnValue:
                  Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>.value(
                      _FakeEither_0<_i11.Failure, List<_i12.TvShow>>()))
          as _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>> searchTvShows(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
              returnValue:
                  Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>.value(
                      _FakeEither_0<_i11.Failure, List<_i12.TvShow>>()))
          as _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, String>> saveTvWatchlist(
          _i13.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#saveTvWatchlist, [tvShow]),
              returnValue: Future<_i2.Either<_i11.Failure, String>>.value(
                  _FakeEither_0<_i11.Failure, String>()))
          as _i7.Future<_i2.Either<_i11.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, String>> removeTvWatchlist(
          _i13.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeTvWatchlist, [tvShow]),
              returnValue: Future<_i2.Either<_i11.Failure, String>>.value(
                  _FakeEither_0<_i11.Failure, String>()))
          as _i7.Future<_i2.Either<_i11.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToTvWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToTvWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>
      getWatchlistTvShows() =>
          (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
                  returnValue:
                      Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>.value(
                          _FakeEither_0<_i11.Failure, List<_i12.TvShow>>()))
              as _i7.Future<_i2.Either<_i11.Failure, List<_i12.TvShow>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [TvShowRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRemoteDataSource extends _i1.Mock
    implements _i14.TvShowRemoteDataSource {
  MockTvShowRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i15.TvShowModel>> getNowPlayingTvShows() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTvShows, []),
              returnValue:
                  Future<List<_i15.TvShowModel>>.value(<_i15.TvShowModel>[]))
          as _i7.Future<List<_i15.TvShowModel>>);
  @override
  _i7.Future<List<_i15.TvShowModel>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
              returnValue:
                  Future<List<_i15.TvShowModel>>.value(<_i15.TvShowModel>[]))
          as _i7.Future<List<_i15.TvShowModel>>);
  @override
  _i7.Future<List<_i15.TvShowModel>> getTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
              returnValue:
                  Future<List<_i15.TvShowModel>>.value(<_i15.TvShowModel>[]))
          as _i7.Future<List<_i15.TvShowModel>>);
  @override
  _i7.Future<_i3.TvShowDetailModel> getTvShowDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
              returnValue: Future<_i3.TvShowDetailModel>.value(
                  _FakeTvShowDetailModel_1()))
          as _i7.Future<_i3.TvShowDetailModel>);
  @override
  _i7.Future<List<_i15.TvShowModel>> getTvShowRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowRecommendations, [id]),
              returnValue:
                  Future<List<_i15.TvShowModel>>.value(<_i15.TvShowModel>[]))
          as _i7.Future<List<_i15.TvShowModel>>);
  @override
  _i7.Future<List<_i15.TvShowModel>> searchTvShows(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
              returnValue:
                  Future<List<_i15.TvShowModel>>.value(<_i15.TvShowModel>[]))
          as _i7.Future<List<_i15.TvShowModel>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [TvShowLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowLocalDataSource extends _i1.Mock
    implements _i16.TvShowLocalDataSource {
  MockTvShowLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlistTv(_i9.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTv, [tvShow]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlistTv(_i9.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTv, [tvShow]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i9.TvShowTable?> getTvShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowById, [id]),
              returnValue: Future<_i9.TvShowTable?>.value())
          as _i7.Future<_i9.TvShowTable?>);
  @override
  _i7.Future<List<_i9.TvShowTable>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue:
                  Future<List<_i9.TvShowTable>>.value(<_i9.TvShowTable>[]))
          as _i7.Future<List<_i9.TvShowTable>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [IOClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockIOClient extends _i1.Mock implements _i4.IOClient {
  MockIOClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i4.IOStreamedResponse> send(_i17.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue: Future<_i4.IOStreamedResponse>.value(
                  _FakeIOStreamedResponse_2()))
          as _i7.Future<_i4.IOStreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  _i7.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i18.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i18.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i18.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i18.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i19.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i19.Uint8List>.value(_i19.Uint8List(0)))
          as _i7.Future<_i19.Uint8List>);
  @override
  String toString() => super.toString();
}
