import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qalbu/domain/entities/doa.dart';
import 'package:qalbu/domain/usecases/get_favorite_doa.dart';
import 'package:qalbu/domain/usecases/get_favorite_status_doa.dart';
import 'package:qalbu/domain/usecases/remove_favorite_doa.dart';
import 'package:qalbu/domain/usecases/save_favorite_doa.dart';

part 'favorite_doa_event.dart';
part 'favorite_doa_state.dart';

class FavoriteDoaBloc extends Bloc<FavoriteDoaEvent, FavoriteDoaState> {
  final GetFavoriteDoa getFavoriteDoa;
  final GetFavoriteStatusDoa getFavoriteStatusDoa;
  final SaveFavoriteDoa saveFavoriteDoa;
  final RemoveFavoriteDoa removeFavoriteDoa;

  FavoriteDoaBloc(
      this.getFavoriteDoa,
      this.getFavoriteStatusDoa,
      this.saveFavoriteDoa,
      this.removeFavoriteDoa,
      ) : super(FavoriteDoaEmpty()) {
    on<GetListEvent>((event, emit) async {
      emit(FavoriteDoaLoading());
      final result = await getFavoriteDoa.execute();

      result.fold(
              (failure) {
            emit(FavoriteDoaError(failure.message));
          },
              (data) {
            data.isEmpty ? emit(FavoriteDoaEmpty()) : emit(FavoriteDoaLoaded(data));
          }
      );
    });

    on<GetStatusDoaEvent>((event, emit) async {
      final result = await getFavoriteStatusDoa.execute(event.id);
      emit(FavoriteDoaStatusLoaded(result));
    });

    on<AddItemDoaEvent>((event, emit) async {
      final doa = event.doa;
      final result = await saveFavoriteDoa.execute(doa);

      result.fold(
              (failure) {
            emit(FavoriteDoaError(failure.message));
          },
              (successMessage) {
            emit(FavoriteDoaSuccess(successMessage));
          }
      );
    });

    on<RemoveItemDoaEvent>((event, emit) async {
      final doa = event.doa;
      final result = await removeFavoriteDoa.execute(doa);

      result.fold(
              (failure) {
                emit(FavoriteDoaError(failure.message));
          },
              (successMessage) {
                emit(FavoriteDoaSuccess(successMessage));
          }
      );
    });
  }
}
