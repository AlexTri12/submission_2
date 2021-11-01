import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv_shows/domain/entities/tv_show_detail.dart';
import 'package:tv_shows/domain/repositories/tv_show_repository.dart';

class RemoveTvWatchlist {
  final TvShowRepository repository;

  RemoveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) {
    return repository.removeTvWatchlist(tvShow);
  }
}