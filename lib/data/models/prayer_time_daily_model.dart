// To parse this JSON data, do
//
//     final prayerTimeDailyModel = prayerTimeDailyModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:qalbu/data/models/datum_model.dart';
import 'package:qalbu/domain/entities/prayer_time_daily.dart';

PrayerTimeDailyModel prayerTimeDailyModelFromJson(String str) =>
    PrayerTimeDailyModel.fromJson(json.decode(str));

String prayerTimeDailyModelToJson(PrayerTimeDailyModel data) =>
    json.encode(data.toJson());

class PrayerTimeDailyModel extends Equatable {
  const PrayerTimeDailyModel({
    required this.code,
    required this.status,
    required this.data,
  });

  final int code;
  final String status;
  final DatumModel data;

  factory PrayerTimeDailyModel.fromJson(Map<String, dynamic> json) =>
      PrayerTimeDailyModel(
        code: json["code"],
        status: json["status"],
        data: DatumModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data.toJson(),
      };

  PrayerTimeDaily toEntity() {
    return PrayerTimeDaily(
      code: code,
      status: status,
      data: data.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        code,
        status,
        data,
      ];
}
