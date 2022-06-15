import 'package:equatable/equatable.dart';
import 'package:qalbu/domain/entities/doa.dart';

class DoaTable extends Equatable {
  final String id;
  final String? doa;

  DoaTable({
    required this.id,
    required this.doa,
  });

  factory DoaTable.fromEntity(Doa doa) => DoaTable(
    id: doa.id,
    doa: doa.doa,
  );

  factory DoaTable.fromMap(Map<String, dynamic> map) => DoaTable(
    id: map['id'],
    doa: map['doa'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'doa': doa,
  };

  Doa toEntity() => Doa.favorite(
    id: id,
    doa: doa,
  );

  @override
  List<Object?> get props => [id, doa];
}