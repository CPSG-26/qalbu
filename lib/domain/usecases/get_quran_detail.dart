import 'package:dartz/dartz.dart';
import 'package:qalbu/common/failure.dart';
import 'package:qalbu/domain/entities/quran_detail.dart';
import 'package:qalbu/domain/repositories/quran_repository.dart';

class GetQuranDetail {
  final QuranRepository repository;

  GetQuranDetail(this.repository);

  Future<Either<Failure, QuranDetail>> execute(int id) {
    return repository.getQuranDetail(id);
  }
}
