import 'package:dartz/dartz.dart';
import 'package:qalbu/common/failure.dart';
import 'package:qalbu/domain/entities/prayer_time_daily.dart';
import 'package:qalbu/domain/entities/prayer_time_monthly.dart';

abstract class PrayerTimeRepository {
  Future<Either<Failure, PrayerTimeMonthly>> getPrayerTimeMonthly(
      double lat, double long, int month, int year);

  Future<Either<Failure, PrayerTimeDaily>> getPrayerTimeDaily(
      String timestamp, double lat, double long);
}
