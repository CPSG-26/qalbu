part of 'prayer_time_daily_bloc.dart';

abstract class PrayerTimeDailyEvent extends Equatable {
  const PrayerTimeDailyEvent();

  @override
  List<Object> get props => [];
}

class FetchPrayerTimeDaily extends PrayerTimeDailyEvent {
  final String timestamp;
  final double lat;
  final double long;

  const FetchPrayerTimeDaily(this.timestamp, this.lat, this.long);

  @override
  List<Object> get props => [timestamp, lat, long];
}
