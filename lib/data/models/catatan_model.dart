class CatatanModel {
  int? id;
  late final String judul;
  late bool selesai;

  CatatanModel({
    this.id,
    required this.judul,
    required this.selesai,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'selesai': selesai ? 1 : 0,
    };
  }
}
