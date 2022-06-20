import 'package:equatable/equatable.dart';
import 'package:qalbu/domain/entities/month.dart';

class MonthModel extends Equatable {
  const MonthModel({
    required this.number,
    required this.en,
  });

  final int number;
  final String en;

  factory MonthModel.fromJson(Map<String, dynamic> json) => MonthModel(
        number: json["number"],
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "en": en,
      };

  Month toEntity() {
    return Month(number: number, en: en);
  }

  @override
  List<Object?> get props => [number, en];
}
