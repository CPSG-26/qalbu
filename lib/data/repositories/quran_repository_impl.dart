import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:qalbu/common/exception.dart';
import 'package:qalbu/common/failure.dart';
import 'package:qalbu/data/datasources/quran_remote_data_source.dart';
import 'package:qalbu/domain/entities/quran.dart';
import 'package:qalbu/domain/entities/quran_detail.dart';
import 'package:qalbu/domain/repositories/quran_repository.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranRemoteDataSource remoteDataSource;

  QuranRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Quran>>> getQuranList() async {
    try {
      final result = await remoteDataSource.getQuranList();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, QuranDetail>> getQuranDetail(int id) async {
    try {
      final result = await remoteDataSource.getQuranDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
