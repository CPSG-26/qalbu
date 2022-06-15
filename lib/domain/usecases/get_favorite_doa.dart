import 'package:dartz/dartz.dart';
import 'package:qalbu/common/failure.dart';
import 'package:qalbu/domain/entities/doa.dart';
import 'package:qalbu/domain/repositories/doa_repository.dart';

class GetFavoriteDoa {
  final DoaRepository doaRepository;

  GetFavoriteDoa(this.doaRepository);

  Future<Either<Failure, List<Doa>>> execute() {
    return doaRepository.getFavoriteDoa();
  }
}
