import 'package:dartz/dartz.dart';
import 'package:qalbu/common/failure.dart';
import 'package:qalbu/domain/entities/quran.dart';
import 'package:qalbu/domain/entities/quran_detail.dart';

abstract class QuranRepository {
  Future<Either<Failure, List<Quran>>> getQuranList();

  Future<Either<Failure, QuranDetail>> getQuranDetail(int id);
}
