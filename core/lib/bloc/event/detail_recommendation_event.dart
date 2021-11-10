import 'package:equatable/equatable.dart';

abstract class DetailRecommendationEvent extends Equatable {
  const DetailRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailRecommendation extends DetailRecommendationEvent {
  final int id;

  FetchDetailRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
