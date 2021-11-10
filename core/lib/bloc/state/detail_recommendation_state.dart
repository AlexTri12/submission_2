import 'package:equatable/equatable.dart';

abstract class DetailRecommendationState extends Equatable {
  const DetailRecommendationState();

  @override
  List<Object> get props => [];
}

class DetailRecommendationEmpty extends DetailRecommendationState {}

class DetailRecommendationLoading extends DetailRecommendationState {}

class DetailRecommendationError extends DetailRecommendationState {
  final String message;

  DetailRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailRecommendationHasData<T> extends DetailRecommendationState {
  final List<T> result;

  DetailRecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}
