import 'package:qalbu/common/encrypt.dart';
import 'package:qalbu/data/models/doa_table.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DoaDatabaseHelper {
  static DoaDatabaseHelper? _databaseHelper;
  DoaDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DoaDatabaseHelper() => _databaseHelper ?? DoaDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblFavorite = 'favorite';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/qalbu_doa.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypt('Your secure password...'),
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblFavorite (
        id TEXT PRIMARY KEY,
        doa TEXT
      );
    ''');
  }

  Future<void> insertFavorite(DoaTable doa) async {
    final db = await database;
    await db!.insert(_tblFavorite, doa.toJson());
  }

  Future<void> removeFavorite(DoaTable doa) async {
    final db = await database;
    await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [doa.id],
    );
  }

  Future<Map<String, dynamic>?> getDoaById(String id) async {
    final db = await database;
    final results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getFavoriteDoa() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results;
  }
}
