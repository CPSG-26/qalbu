import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qalbu/domain/entities/doa.dart';
import 'package:qalbu/domain/usecases/get_doa_detail.dart';

part 'doa_detail_event.dart';
part 'doa_detail_state.dart';

class DoaDetailBloc extends Bloc<DoaDetailEvent, DoaDetailState> {
  final GetDoaDetail getDoaDetail;

  DoaDetailBloc(this.getDoaDetail) : super(DoaDetailEmpty()) {
    on<GetDoaDetailEvent>((event, emit) async {
      emit(DoaDetailLoading());
      final result = await getDoaDetail.execute(event.id);

      result.fold((failure) {
        emit(DoaDetailError(failure.message));
      }, (data) {
        emit(DoaDetailLoaded(data));
      });
    });
  }
}
