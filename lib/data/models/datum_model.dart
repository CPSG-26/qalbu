import 'package:equatable/equatable.dart';
import 'package:qalbu/data/models/date_model.dart';
import 'package:qalbu/data/models/timings_model.dart';
import 'package:qalbu/domain/entities/datum.dart';

class DatumModel extends Equatable {
  const DatumModel({
    required this.timings,
    required this.date,
  });

  final TimingsModel timings;
  final DateModel date;

  factory DatumModel.fromJson(Map<String, dynamic> json) => DatumModel(
        timings: TimingsModel.fromJson(json["timings"]),
        date: DateModel.fromJson(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "timings": timings.toJson(),
      };

  Datum toEntity() {
    return Datum(timings: timings.toEntity(), date: date.toEntity());
  }

  @override
  List<Object?> get props => [timings];
}
