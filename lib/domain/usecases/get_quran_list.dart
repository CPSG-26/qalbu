import 'package:dartz/dartz.dart';
import 'package:qalbu/common/failure.dart';
import 'package:qalbu/domain/entities/quran.dart';
import 'package:qalbu/domain/repositories/quran_repository.dart';

class GetQuranList {
  final QuranRepository repository;

  GetQuranList(this.repository);

  Future<Either<Failure, List<Quran>>> execute() {
    return repository.getQuranList();
  }
}
