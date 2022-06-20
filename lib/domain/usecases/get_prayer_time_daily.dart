import 'package:dartz/dartz.dart';
import 'package:qalbu/common/failure.dart';
import 'package:qalbu/domain/entities/prayer_time_daily.dart';
import 'package:qalbu/domain/repositories/prayer_time_repository.dart';

class GetPrayerTimeDaily {
  final PrayerTimeRepository repository;

  GetPrayerTimeDaily(this.repository);

  Future<Either<Failure, PrayerTimeDaily>> execute(
      String timestamp, double lat, double long) {
    return repository.getPrayerTimeDaily(timestamp, lat, long);
  }
}
