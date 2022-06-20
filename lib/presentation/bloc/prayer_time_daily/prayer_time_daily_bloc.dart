import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qalbu/domain/entities/prayer_time_daily.dart';
import 'package:qalbu/domain/usecases/get_prayer_time_daily.dart';

part 'prayer_time_daily_event.dart';

part 'prayer_time_daily_state.dart';

class PrayerTimeDailyBloc
    extends Bloc<PrayerTimeDailyEvent, PrayerTimeDailyState> {
  final GetPrayerTimeDaily _getPrayerTimeDaily;

  PrayerTimeDailyBloc(this._getPrayerTimeDaily)
      : super(PrayerTimeDailyEmpty()) {
    on<FetchPrayerTimeDaily>((event, emit) async {
      emit(PrayerTimeDailyLoading());

      final result = await _getPrayerTimeDaily.execute(
          event.timestamp, event.lat, event.long);

      result.fold(
        (failure) => emit(PrayerTimeDailyError(failure.message)),
        (data) => emit(
          PrayerTimeDailyHasData(data),
        ),
      );
    });
  }
}
