part of 'prayer_time_daily_bloc.dart';

abstract class PrayerTimeDailyState extends Equatable {
  const PrayerTimeDailyState();

  @override
  List<Object> get props => [];
}

class PrayerTimeDailyEmpty extends PrayerTimeDailyState {}

class PrayerTimeDailyLoading extends PrayerTimeDailyState {}

class PrayerTimeDailyHasData extends PrayerTimeDailyState {
  final PrayerTimeDaily prayerTime;

  const PrayerTimeDailyHasData(this.prayerTime);

  @override
  List<Object> get props => [prayerTime];
}

class PrayerTimeDailyError extends PrayerTimeDailyState {
  final String message;

  const PrayerTimeDailyError(this.message);

  @override
  List<Object> get props => [message];
}
