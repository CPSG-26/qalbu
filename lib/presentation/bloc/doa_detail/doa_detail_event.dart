part of 'doa_detail_bloc.dart';

abstract class DoaDetailEvent extends Equatable {
  const DoaDetailEvent();

  @override
  List<Object> get props => [];
}

class GetDoaDetailEvent extends DoaDetailEvent {
  final String id;

  const GetDoaDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
