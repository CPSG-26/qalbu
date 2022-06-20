import 'package:equatable/equatable.dart';
import 'package:qalbu/data/models/gregorian_model.dart';
import 'package:qalbu/domain/entities/date.dart';

class DateModel extends Equatable {
  const DateModel({required this.readable, required this.gregorian});

  final String readable;
  final GregorianModel gregorian;

  factory DateModel.fromJson(Map<String, dynamic> json) => DateModel(
        readable: json["readable"],
        gregorian: GregorianModel.fromJson(json["gregorian"]),
      );

  Map<String, dynamic> toJson() => {
        "readable": readable,
        "gregorian": gregorian.toJson(),
      };

  Date toEntity() {
    return Date(readable: readable, gregorian: gregorian.toEntity());
  }

  @override
  List<Object?> get props => [readable, gregorian];
}
