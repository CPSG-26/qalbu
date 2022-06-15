import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:qalbu/domain/entities/doa.dart';

List<DoaModel> doaModelFromJson(String str) => List<DoaModel>.from(json.decode(str).map((x) => DoaModel.fromJson(x)));

String doaModelToJson(List<DoaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoaModel extends Equatable {
  DoaModel({
    required this.id,
    required this.doa,
    required this.ayat,
    required this.latin,
    required this.artinya,
  });

  final String id;
  final String doa;
  final String ayat;
  final String latin;
  final String artinya;

  factory DoaModel.fromJson(Map<String, dynamic> json) => DoaModel(
    id: json["id"],
    doa: json["doa"],
    ayat: json["ayat"],
    latin: json["latin"],
    artinya: json["artinya"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "doa": doa,
    "ayat": ayat,
    "latin": latin,
    "artinya": artinya,
  };

  Doa toEntity() {
    return Doa(
        id: id,
        doa: doa,
        ayat: ayat,
        latin: latin,
        artinya: artinya
    );
  }

  @override
  List<Object?> get props => [
    id,
    doa,
    ayat,
    latin,
    artinya,
  ];
}
