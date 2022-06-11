// To parse this JSON data, do
//
//     final quranDetailModel = quranDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:qalbu/data/models/ayat_model.dart';
import 'package:qalbu/domain/entities/quran_detail.dart';

QuranDetailModel quranDetailModelFromJson(String str) =>
    QuranDetailModel.fromJson(json.decode(str));

String quranDetailModelToJson(QuranDetailModel data) =>
    json.encode(data.toJson());

class QuranDetailModel extends Equatable {
  const QuranDetailModel({
    required this.status,
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audio,
    required this.ayat,
  });

  final bool status;
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final String audio;
  final List<AyatModel> ayat;

  factory QuranDetailModel.fromJson(Map<String, dynamic> json) =>
      QuranDetailModel(
        status: json["status"],
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["nama_latin"],
        jumlahAyat: json["jumlah_ayat"],
        tempatTurun: json["tempat_turun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audio: json["audio"],
        ayat: List<AyatModel>.from(
            json["ayat"].map((x) => AyatModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "nomor": nomor,
        "nama": nama,
        "nama_latin": namaLatin,
        "jumlah_ayat": jumlahAyat,
        "tempat_turun": tempatTurun,
        "arti": arti,
        "deskripsi": deskripsi,
        "audio": audio,
        "ayat": List<dynamic>.from(ayat.map((x) => x.toJson())),
      };

  QuranDetail toEntity() {
    return QuranDetail(
      status: status,
      nomor: nomor,
      nama: nama,
      namaLatin: namaLatin,
      jumlahAyat: jumlahAyat,
      tempatTurun: tempatTurun,
      arti: arti,
      deskripsi: deskripsi,
      audio: audio,
      ayat: ayat.map((ayat) => ayat.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        status,
        nomor,
        nama,
        namaLatin,
        jumlahAyat,
        tempatTurun,
        arti,
        deskripsi,
        audio,
        ayat,
      ];
}
