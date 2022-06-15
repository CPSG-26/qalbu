part of 'doa_detail_bloc.dart';

abstract class DoaDetailState extends Equatable {
  const DoaDetailState();

  @override
  List<Object> get props => [];
}

class DoaDetailEmpty extends DoaDetailState {}

class DoaDetailLoading extends DoaDetailState {}

class DoaDetailError extends DoaDetailState {
  final String message;

  const DoaDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DoaDetailLoaded extends DoaDetailState {
  final Doa result;

  const DoaDetailLoaded(this.result);

  @override
  List<Object> get props => [result];
}
