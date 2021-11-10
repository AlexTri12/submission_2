import 'package:equatable/equatable.dart';

abstract class DetailWatchlistStatus extends Equatable {
  const DetailWatchlistStatus();

  @override
  List<Object> get props => [];
}

class DetailWatchlistLoading extends DetailWatchlistStatus {}

class IsAddedToWatchlist extends DetailWatchlistStatus {
  final bool isAddedToWatchlist;
  final String message;

  IsAddedToWatchlist(this.isAddedToWatchlist, this.message);

  @override
  List<Object> get props => [isAddedToWatchlist, message];
}
