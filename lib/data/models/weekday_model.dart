import 'package:equatable/equatable.dart';
import 'package:qalbu/domain/entities/weekday.dart';

class WeekdayModel extends Equatable {
  const WeekdayModel({
    required this.en,
  });

  final String en;

  factory WeekdayModel.fromJson(Map<String, dynamic> json) => WeekdayModel(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };

  Weekday toEntity() {
    return Weekday(en: en);
  }

  @override
  List<Object?> get props => [en];
}
