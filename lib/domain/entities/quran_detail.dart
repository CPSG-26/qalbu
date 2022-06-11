import 'package:equatable/equatable.dart';
import 'package:qalbu/domain/entities/ayat.dart';

class QuranDetail extends Equatable {
  const QuranDetail({
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
  final List<Ayat> ayat;

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
