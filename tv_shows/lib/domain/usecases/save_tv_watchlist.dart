import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv_shows/domain/entities/tv_show_detail.dart';
import 'package:tv_shows/domain/repositories/tv_show_repository.dart';

class SaveTvWatchlist {
  final TvShowRepository repository;

  SaveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) async {
    return repository.saveTvWatchlist(tvShow);
  }
}