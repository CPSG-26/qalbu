part of 'prayer_time_monthly_bloc.dart';

abstract class PrayerTimeMonthlyState extends Equatable {
  const PrayerTimeMonthlyState();

  @override
  List<Object> get props => [];
}

class PrayerTimeMonthlyEmpty extends PrayerTimeMonthlyState {}

class PrayerTimeMonthlyLoading extends PrayerTimeMonthlyState {}

class PrayerTimeMonthlyHasData extends PrayerTimeMonthlyState {
  final PrayerTimeMonthly prayerTimeList;

  const PrayerTimeMonthlyHasData(this.prayerTimeList);

  @override
  List<Object> get props => [prayerTimeList];
}

class PrayerTimeMonthlyError extends PrayerTimeMonthlyState {
  final String message;

  const PrayerTimeMonthlyError(this.message);

  @override
  List<Object> get props => [message];
}
