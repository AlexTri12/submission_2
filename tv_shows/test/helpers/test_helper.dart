import 'package:tv_shows/data/datasources/db/database_helper_tv.dart';
import 'package:tv_shows/data/datasources/tv_show_local_data_source.dart';
import 'package:tv_shows/data/datasources/tv_show_remote_data_source.dart';
import 'package:tv_shows/domain/repositories/tv_show_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  DatabaseHelperTv,
  TvShowRepository,
  TvShowRemoteDataSource,
  TvShowLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
