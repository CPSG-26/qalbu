import 'package:dartz/dartz.dart';
import 'package:qalbu/common/failure.dart';
import 'package:qalbu/domain/entities/doa.dart';

abstract class DoaRepository {
  Future<Either<Failure, List<Doa>>> getDoaList();
  Future<Either<Failure, Doa>> getDoaDetail(String id);
  Future<Either<Failure, String>> saveFavorite(Doa doa);
  Future<Either<Failure, String>> removeFavorite(Doa doa);
  Future<bool> isAddedToFavorite(String id);
  Future<Either<Failure, List<Doa>>> getFavoriteDoa();
}
