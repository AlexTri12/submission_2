import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class FetchDetail extends DetailEvent {
  final int id;

  FetchDetail(this.id);

  @override
  List<Object> get props => [id];
}
