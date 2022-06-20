import 'package:equatable/equatable.dart';
import 'package:qalbu/domain/entities/datum.dart';

class PrayerTimeMonthly extends Equatable {
  const PrayerTimeMonthly({
    required this.code,
    required this.status,
    required this.data,
  });

  final int code;
  final String status;
  final List<Datum> data;

  @override
  List<Object?> get props => [
        code,
        status,
        data,
      ];
}
