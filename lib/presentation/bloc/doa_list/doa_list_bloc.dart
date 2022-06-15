import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qalbu/domain/entities/doa.dart';
import 'package:qalbu/domain/usecases/get_doa_list.dart';

part 'doa_list_event.dart';
part 'doa_list_state.dart';

class DoaListBloc extends Bloc<DoaListEvent, DoaListState> {
  final GetDoaList getDoaList;

  DoaListBloc(
      this.getDoaList
      ) : super(DoaListEmpty()) {
    on<GetDoaListEvent>((event, emit) async {
      emit(DoaListLoading());
      final result = await getDoaList.execute();

      result.fold(
              (failure) {
                emit(DoaListError(failure.message));
          },
              (data) {
                emit(DoaListLoaded(data));
          }
      );
    });
  }
}
