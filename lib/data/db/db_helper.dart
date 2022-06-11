import 'package:qalbu/data/models/catatan_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? _database;

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();
    const dbName = 'catatan_ibadah.db';
    final path = join(dbPath, dbName);

    _database = await openDatabase(
      path,
      onCreate: (db, version) {
        return _createDb(db, version);
      },
      version: 1,
    );

    return _database!;
  }

  /// Membuat tabel di database
  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE catatan_ibadah(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT,
        selesai INTEGER
      )
    ''');
  }

  /// Menambahkan data ke database
  Future<void> tambahCatatan(CatatanModel catatan) async {
    final db = await database;
    await db.insert(
      'catatan_ibadah',
      catatan.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Mendapatkan semua catatan dari database
  Future<List<CatatanModel>> getCatatan() async {
    final db = await database;
    List<Map<String, dynamic>> catatanList = await db.query(
      'catatan_ibadah',

      /// Mengurutkan catatan dari yang terbaru
      orderBy: 'id DESC',
    );

    return List.generate(
      catatanList.length,
      (index) => CatatanModel(
        id: catatanList[index]['id'],
        judul: catatanList[index]['judul'],
        selesai: catatanList[index]['selesai'] == 0 ? false : true,
      ),
    );
  }

  /// Menghapus data
  Future<void> hapusCatatan(CatatanModel catatan) async {
    final db = await database;
    await db.delete(
      'catatan_ibadah',
      where: 'id == ?',
      whereArgs: [catatan.id],
    );
  }
}
