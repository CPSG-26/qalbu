// To parse this JSON data, do
//
//     final prayerTimeMonthlyModel = prayerTimeMonthlyModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:qalbu/data/models/datum_model.dart';
import 'package:qalbu/domain/entities/prayer_time_monthly.dart';

PrayerTimeMonthlyModel prayerTimeMonthlyModelFromJson(String str) =>
    PrayerTimeMonthlyModel.fromJson(json.decode(str));

String prayerTimeMonthlyModelToJson(PrayerTimeMonthlyModel data) =>
    json.encode(data.toJson());

class PrayerTimeMonthlyModel extends Equatable {
  const PrayerTimeMonthlyModel({
    required this.code,
    required this.status,
    required this.data,
  });

  final int code;
  final String status;
  final List<DatumModel> data;

  factory PrayerTimeMonthlyModel.fromJson(Map<String, dynamic> json) =>
      PrayerTimeMonthlyModel(
        code: json["code"],
        status: json["status"],
        data: List<DatumModel>.from(
            json["data"].map((x) => DatumModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  PrayerTimeMonthly toEntity() {
    return PrayerTimeMonthly(
      code: code,
      status: status,
      data: data.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        code,
        status,
        data,
      ];
}
