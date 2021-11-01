import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/repositories/tv_show_repository.dart';

class GetTvShowRecommendations {
  final TvShowRepository repository;

  GetTvShowRecommendations(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(int id) {
    return repository.getTvShowRecommendations(id);
  }
}