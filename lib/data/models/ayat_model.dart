import 'package:equatable/equatable.dart';
import 'package:qalbu/domain/entities/ayat.dart';

class AyatModel extends Equatable {
  const AyatModel({
    required this.id,
    required this.surah,
    required this.nomor,
    required this.ar,
    required this.tr,
    required this.idn,
  });

  final int id;
  final int surah;
  final int nomor;
  final String ar;
  final String tr;
  final String idn;

  factory AyatModel.fromJson(Map<String, dynamic> json) => AyatModel(
        id: json["id"],
        surah: json["surah"],
        nomor: json["nomor"],
        ar: json["ar"],
        tr: json["tr"],
        idn: json["idn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "surah": surah,
        "nomor": nomor,
        "ar": ar,
        "tr": tr,
        "idn": idn,
      };

  Ayat toEntity() {
    return Ayat(
      id: id,
      surah: surah,
      nomor: nomor,
      ar: ar,
      tr: tr,
      idn: idn,
    );
  }

  @override
  List<Object?> get props => [
        id,
        surah,
        nomor,
        ar,
        tr,
        idn,
      ];
}
