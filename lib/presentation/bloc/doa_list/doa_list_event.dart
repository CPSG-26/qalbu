part of 'doa_list_bloc.dart';

abstract class DoaListEvent extends Equatable {
  const DoaListEvent();

  @override
  List<Object> get props => [];
}

class GetDoaListEvent extends DoaListEvent {}
