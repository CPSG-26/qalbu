import 'package:dartz/dartz.dart';
import 'package:qalbu/common/failure.dart';
import 'package:qalbu/domain/entities/doa.dart';
import 'package:qalbu/domain/repositories/doa_repository.dart';

class SaveFavoriteDoa {
  final DoaRepository doaRepository;

  SaveFavoriteDoa(this.doaRepository);

  Future<Either<Failure, String>> execute(Doa doa) {
    return doaRepository.saveFavorite(doa);
  }
}
