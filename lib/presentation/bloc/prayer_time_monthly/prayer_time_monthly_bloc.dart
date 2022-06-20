import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qalbu/domain/entities/prayer_time_monthly.dart';
import 'package:qalbu/domain/usecases/get_prayer_time_monthly.dart';

part 'prayer_time_monthly_event.dart';

part 'prayer_time_monthly_state.dart';

class PrayerTimeMonthlyBloc
    extends Bloc<PrayerTimeMonthlyEvent, PrayerTimeMonthlyState> {
  final GetPrayerTimeMonthly _getPrayerTimeMonthly;

  PrayerTimeMonthlyBloc(this._getPrayerTimeMonthly)
      : super(PrayerTimeMonthlyEmpty()) {
    on<FetchPrayerTimeMonthly>((event, emit) async {
      emit(PrayerTimeMonthlyLoading());

      final result = await _getPrayerTimeMonthly.execute(
          event.lat, event.long, event.month, event.year);

      result.fold(
        (failure) => emit(PrayerTimeMonthlyError(failure.message)),
        (data) => emit(
          PrayerTimeMonthlyHasData(data),
        ),
      );
    });
  }
}
