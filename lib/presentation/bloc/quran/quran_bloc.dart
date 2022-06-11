import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qalbu/domain/entities/quran.dart';
import 'package:qalbu/domain/usecases/get_quran_list.dart';

part 'quran_event.dart';

part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  final GetQuranList _getQuranList;

  QuranBloc(this._getQuranList) : super(QuranEmpty()) {
    on<FetchQuranList>((event, emit) async {
      emit(QuranLoading());

      final result = await _getQuranList.execute();

      result.fold(
        (failure) => emit(QuranError(failure.message)),
        (data) => emit(
          QuranHasData(data),
        ),
      );
    });
  }
}
