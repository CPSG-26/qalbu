import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qalbu/domain/entities/quran_detail.dart';
import 'package:qalbu/domain/usecases/get_quran_detail.dart';

part 'quran_detail_event.dart';

part 'quran_detail_state.dart';

class QuranDetailBloc extends Bloc<QuranDetailEvent, QuranDetailState> {
  final GetQuranDetail _getQuranDetail;

  QuranDetailBloc(this._getQuranDetail) : super(QuranEmpty()) {
    on<FetchQuranDetail>((event, emit) async {
      emit(QuranLoading());

      final result = await _getQuranDetail.execute(event.id);

      result.fold(
        (failure) => emit(
          QuranError(failure.message),
        ),
        (data) => emit(
          QuranHasData(data),
        ),
      );
    });
  }
}
