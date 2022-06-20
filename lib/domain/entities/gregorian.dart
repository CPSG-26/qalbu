import 'package:equatable/equatable.dart';
import 'package:qalbu/domain/entities/month.dart';
import 'package:qalbu/domain/entities/weekday.dart';

class Gregorian extends Equatable {
  const Gregorian({
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
  final Weekday weekday;
  final Month month;
  final String year;

  @override
  List<Object?> get props => [date, format, day, weekday, month, year];
}
