import 'package:qalbu/common/exception.dart';
import 'package:qalbu/data/db/doa_database_helper.dart';
import 'package:qalbu/data/models/doa_table.dart';

abstract class DoaLocalDataSource {
  Future<String> insertFavorite(DoaTable doa);
  Future<String> removeFavorite(DoaTable doa);
  Future<DoaTable?> getDoaById(String id);
  Future<List<DoaTable>> getFavoriteDoa();
}

class DoaLocalDataSourceImpl implements DoaLocalDataSource {
  final DoaDatabaseHelper databaseHelper;

  DoaLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertFavorite(DoaTable doa) async {
    try {
      await databaseHelper.insertFavorite(doa);
      return 'Ditambahkan ke Tersimpan';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFavorite(DoaTable doa) async {
    try {
      await databaseHelper.removeFavorite(doa);
      return 'Dihapus dari Tersimpan';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<DoaTable?> getDoaById(String id) async {
    final result = await databaseHelper.getDoaById(id);
    if (result != null) {
      return DoaTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<DoaTable>> getFavoriteDoa() async {
    final result = await databaseHelper.getFavoriteDoa();
    return result.map((data) => DoaTable.fromMap(data)).toList();
  }
}
