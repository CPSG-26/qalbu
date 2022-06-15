part of 'favorite_doa_bloc.dart';

abstract class FavoriteDoaEvent extends Equatable {
  const FavoriteDoaEvent();

  @override
  List<Object> get props => [];
}

class GetListEvent extends FavoriteDoaEvent {}

class GetStatusDoaEvent extends FavoriteDoaEvent {
  final String id;

  const GetStatusDoaEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddItemDoaEvent extends FavoriteDoaEvent {
  final Doa doa;

  const AddItemDoaEvent(this.doa);

  @override
  List<Object> get props => [doa];
}

class RemoveItemDoaEvent extends FavoriteDoaEvent {
  final Doa doa;

  const RemoveItemDoaEvent(this.doa);

  @override
  List<Object> get props => [doa];
}
