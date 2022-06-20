import 'package:dartz/dartz.dart';
import 'package:qalbu/common/failure.dart';
import 'package:qalbu/domain/entities/prayer_time_monthly.dart';
import 'package:qalbu/domain/repositories/prayer_time_repository.dart';

class GetPrayerTimeMonthly {
  final PrayerTimeRepository repository;

  GetPrayerTimeMonthly(this.repository);

  Future<Either<Failure, PrayerTimeMonthly>> execute(
      double lat, double long, int month, int year) {
    return repository.getPrayerTimeMonthly(lat, long, month, year);
  }
}
