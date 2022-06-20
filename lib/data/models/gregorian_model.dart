import 'package:equatable/equatable.dart';
import 'package:qalbu/data/models/weekday_model.dart';
import 'package:qalbu/domain/entities/gregorian.dart';

import 'month_model.dart';

class GregorianModel extends Equatable {
  const GregorianModel({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
  });

  final String date;
  final String format;
  final String day;
  final WeekdayModel weekday;
  final MonthModel month;
  final String year;

  factory GregorianModel.fromJson(Map<String, dynamic> json) => GregorianModel(
        date: json["date"],
        format: json["format"],
        day: json["day"],
        weekday: WeekdayModel.fromJson(json["weekday"]),
        month: MonthModel.fromJson(json["month"]),
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "format": format,
        "day": day,
        "weekday": weekday.toJson(),
        "month": month.toJson(),
        "year": year,
      };

  Gregorian toEntity() {
    return Gregorian(
        date: date,
        format: format,
        day: day,
        weekday: weekday.toEntity(),
        month: month.toEntity(),
        year: year);
  }

  @override
  List<Object?> get props => [date, format, day, weekday, month, year];
}
