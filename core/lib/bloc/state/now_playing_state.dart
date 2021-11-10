import 'package:equatable/equatable.dart';

abstract class NowPlayingState extends Equatable {
  const NowPlayingState();

  @override
  List<Object> get props => [];
}

class NowPlayingEmpty extends NowPlayingState {}

class NowPlayingLoading extends NowPlayingState {}

class NowPlayingError extends NowPlayingState {
  final String message;

  NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingHasData<T> extends NowPlayingState {
  final List<T> result;

  NowPlayingHasData(this.result);

  @override
  List<Object> get props => [result];
}
