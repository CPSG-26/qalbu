import 'package:dartz/dartz.dart';
import 'package:qalbu/common/failure.dart';
import 'package:qalbu/domain/entities/doa.dart';
import 'package:qalbu/domain/repositories/doa_repository.dart';

class GetDoaDetail {
  final DoaRepository doaRepository;

  GetDoaDetail(this.doaRepository);

  Future<Either<Failure, Doa>> execute(String id) {
    return doaRepository.getDoaDetail(id);
  }
}
