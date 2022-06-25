// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Doa extends Equatable {
  Doa({
    required this.id,
    required this.doa,
    required this.ayat,
    required this.latin,
    required this.artinya,
  });

  Doa.favorite({
    required this.id,
    required this.doa,
  });

  String id;
  String? doa;
  String? ayat;
  String? latin;
  String? artinya;

  @override
  List<Object?> get props => [
    id,
    doa,
    ayat,
    latin,
    artinya,
  ];
}
