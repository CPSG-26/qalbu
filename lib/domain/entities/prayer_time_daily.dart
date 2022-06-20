import 'package:equatable/equatable.dart';
import 'package:qalbu/domain/entities/datum.dart';

class PrayerTimeDaily extends Equatable {
  const PrayerTimeDaily({
    required this.code,
    required this.status,
    required this.data,
  });

  final int code;
  final String status;
  final Datum data;

  @override
  List<Object?> get props => [
        code,
        status,
        data,
      ];
}
