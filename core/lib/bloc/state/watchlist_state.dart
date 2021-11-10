import 'package:equatable/equatable.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistError extends WatchlistState {
  final String message;

  WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData<T> extends WatchlistState {
  final List<T> result;

  WatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}
