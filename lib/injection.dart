import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:movies/data/datasources/db/database_helper.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies/data/repositories/movie_repository_impl.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:movies/movies.dart';
import 'package:tv_shows/data/datasources/db/database_helper_tv.dart';
import 'package:tv_shows/data/datasources/tv_show_local_data_source.dart';
import 'package:tv_shows/data/datasources/tv_show_remote_data_source.dart';
import 'package:tv_shows/data/repositories/tv_show_repository_impl.dart';
import 'package:tv_shows/domain/repositories/tv_show_repository.dart';
import 'package:tv_shows/domain/usecases/get_now_playing_tv_shows.dart';
import 'package:tv_shows/domain/usecases/get_popular_tv_shows.dart';
import 'package:tv_shows/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:tv_shows/domain/usecases/get_tv_show_detail.dart';
import 'package:tv_shows/domain/usecases/get_tv_show_recommendations.dart';
import 'package:tv_shows/domain/usecases/get_watchlist_tv_show_status.dart';
import 'package:tv_shows/domain/usecases/get_watchlist_tv_shows.dart';
import 'package:tv_shows/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv_shows/domain/usecases/save_tv_watchlist.dart';
import 'package:tv_shows/domain/usecases/search_tv_shows.dart';
import 'package:tv_shows/tv_shows.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<SecurityContext> get globalContext async {
  final sslCert = await rootBundle.load('certificates/themoviedb-certification.cer');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}

Future<void> getIoClient() async {
  HttpClient httpClient = HttpClient(context: await globalContext);
  httpClient.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;
  IOClient ioClient = IOClient(httpClient);
  locator.registerSingleton(ioClient);
}

void init() {
  // Provider
  // locator.registerFactory(
  //   () => MovieListNotifier(
  //     getNowPlayingMovies: locator(),
  //     getPopularMovies: locator(),
  //     getTopRatedMovies: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => MovieDetailNotifier(
  //     getMovieDetail: locator(),
  //     getMovieRecommendations: locator(),
  //     getWatchListStatus: locator(),
  //     saveWatchlist: locator(),
  //     removeWatchlist: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => MovieSearchNotifier(
  //     searchMovies: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => PopularMoviesNotifier(
  //     locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => TopRatedMoviesNotifier(
  //     getTopRatedMovies: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => WatchlistMovieNotifier(
  //     getWatchlistMovies: locator(),
  //   ),
  // );

  // locator.registerFactory(
  //       () => TvShowListNotifier(
  //     getNowPlayingTvShows: locator(),
  //     getPopularTvShows: locator(),
  //     getTopRatedTvShows: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //       () => TvShowDetailNotifier(
  //     getTvShowDetail: locator(),
  //     getTvShowRecommendations: locator(),
  //     getWatchlistTvShowStatus: locator(),
  //     saveTvWatchlist: locator(),
  //     removeTvWatchlist: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //       () => TvShowSearchNotifier(
  //     searchTvShows: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //       () => PopularTvShowsNotifier(
  //     locator(),
  //   ),
  // );
  // locator.registerFactory(
  //       () => TopRatedTvShowsNotifier(
  //     getTopRatedTvShows: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //       () => WatchlistTvShowNotifier(
  //     getWatchlistTvShows: locator(),
  //   ),
  // );

  // Bloc
  locator.registerFactory(
      () => MovieSearchBloc(
        locator(),
      ),
  );
  locator.registerFactory(
      () => MovieDetailBloc(
        locator(),
      ),
  );
  locator.registerFactory(
      () => MovieDetailRecommendationBloc(
        locator(),
      ),
  );
  locator.registerFactory(
      () => MovieNowPlayingBloc(
        locator(),
      ),
  );
  locator.registerFactory(
      () => MoviePopularBloc(
        locator(),
      ),
  );
  locator.registerFactory(
      () => MovieTopRatedBloc(
        locator(),
      ),
  );
  locator.registerFactory(
      () => MovieWatchlistBloc(
        locator(),
      ),
  );
  locator.registerFactory(
      () => MovieDetailWatchlistBloc(
        locator(),
        locator(),
        locator(),
      ),
  );

  locator.registerFactory(
        () => TvShowSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvShowDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvShowDetailRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvShowNowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvShowPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvShowTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvShowWatchlistBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvShowDetailWatchlistBloc(
      locator(),
      locator(),
      locator(),
    ),
  );

  // Use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvShows(locator()));
  locator.registerLazySingleton(() => GetPopularTvShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowDetail(locator()));
  locator.registerLazySingleton(() => GetTvShowRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvShows(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShowStatus(locator()));
  locator.registerLazySingleton(() => SaveTvWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShows(locator()));

  // Repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvShowRepository>(
        () => TvShowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // Data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(ioClient: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvShowRemoteDataSource>(
          () => TvShowRemoteDataSourceImpl(ioClient: locator()));
  locator.registerLazySingleton<TvShowLocalDataSource>(
          () => TvShowLocalDataSourceImpl(databaseHelper: locator()));

  // Helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTv>(() => DatabaseHelperTv());
}
