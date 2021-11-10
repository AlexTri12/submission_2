import 'package:equatable/equatable.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailEmpty extends DetailState {}

class DetailLoading extends DetailState {}

class DetailError extends DetailState {
  final String message;

  DetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailHasData<T> extends DetailState {
  final T result;

  DetailHasData(this.result);

  @override
  List<Object> get props => [result.toString()];
}
