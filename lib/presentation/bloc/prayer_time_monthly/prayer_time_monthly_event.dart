part of 'prayer_time_monthly_bloc.dart';

abstract class PrayerTimeMonthlyEvent extends Equatable {
  const PrayerTimeMonthlyEvent();

  @override
  List<Object> get props => [];
}

class FetchPrayerTimeMonthly extends PrayerTimeMonthlyEvent {
  final double lat;
  final double long;
  final int month;
  final int year;

  const FetchPrayerTimeMonthly(this.lat, this.long, this.month, this.year);

  @override
  List<Object> get props => [lat, long, month, year];
}
