part of 'favorite_doa_bloc.dart';

abstract class FavoriteDoaState extends Equatable {
  const FavoriteDoaState();

  @override
  List<Object> get props => [];
}

class FavoriteDoaEmpty extends FavoriteDoaState {
  final String message = 'You haven\'t saved any doa yet!';
}

class FavoriteDoaLoading extends FavoriteDoaState {}

class FavoriteDoaError extends FavoriteDoaState {
  final String message;

  const FavoriteDoaError(this.message);

  @override
  List<Object> get props => [message];
}

class FavoriteDoaSuccess extends FavoriteDoaState {
  final String message;

  const FavoriteDoaSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class FavoriteDoaLoaded extends FavoriteDoaState {
  final List<Doa> result;

  const FavoriteDoaLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class FavoriteDoaStatusLoaded extends FavoriteDoaState {
  final bool result;

  const FavoriteDoaStatusLoaded(this.result);

  @override
  List<Object> get props => [result];
}
