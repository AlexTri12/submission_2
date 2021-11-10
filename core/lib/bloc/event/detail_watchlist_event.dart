import 'package:equatable/equatable.dart';

abstract class DetailWatchlistEvent extends Equatable {
  const DetailWatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddToWatchlist<T> extends DetailWatchlistEvent {
  final T detail;

  AddToWatchlist(this.detail);

  @override
  List<Object> get props => [detail.toString()];
}

class RemoveFromWatchlist<T> extends DetailWatchlistEvent {
  final T detail;

  RemoveFromWatchlist(this.detail);

  @override
  List<Object> get props => [detail.toString()];
}

class LoadWatchlistStatus extends DetailWatchlistEvent {
  final int id;

  LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
