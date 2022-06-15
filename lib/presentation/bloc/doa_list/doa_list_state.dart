part of 'doa_list_bloc.dart';

abstract class DoaListState extends Equatable {
  const DoaListState();

  @override
  List<Object> get props => [];
}

class DoaListEmpty extends DoaListState {
  final String message = 'No Data';
}

class DoaListLoading extends DoaListState {}

class DoaListError extends DoaListState {
  final String message;

  const DoaListError(this.message);

  @override
  List<Object> get props => [message];
}

class DoaListLoaded extends DoaListState {
  final List<Doa> result;

  const DoaListLoaded(this.result);

  @override
  List<Object> get props => [result];
}
